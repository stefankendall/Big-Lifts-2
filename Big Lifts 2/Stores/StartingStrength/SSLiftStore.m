#import <MRCEnumerable/NSArray+Enumerable.h>
#import "SSLiftStore.h"
#import "SSLift.h"
#import "BLStoreManager.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation SSLiftStore {
}

- (void)setupDefaults {
    if ([self count] == 0) {
        [self addMissingLifts:@[@"Bench", @"Deadlift", @"Power Clean", @"Press", @"Squat"]];
    }
}

- (void)onLoad {
    [[SettingsStore instance] registerChangeListener:^{
        [self adjustForKg];
    }];
}

- (void)createLift:(NSString *)name withOrder:(double)order withIncrement:(int)increment {
    SSLift *lift = [NSEntityDescription insertNewObjectForEntityForName:@"SSLift" inManagedObjectContext:[BLStoreManager context]];
    [lift setName:name];
    [lift setOrder:[NSNumber numberWithDouble:order]];
    [lift setIncrement:[NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:increment] decimalValue]]];
}

- (void)adjustForKg {
    SettingsStore *settingsStore = [SettingsStore instance];
    Settings *settings = [settingsStore first];
    if ([settings.units isEqualToString:@"kg"]) {
        NSArray *liftNames = [[self findAll] collect:^id(Lift *lift) {
            return lift.name;
        }];
        [liftNames each:^(NSString *liftName) {
            SSLift *lift = [[SSLiftStore instance] find:@"name" value:liftName];
            lift.increment = [settingsStore defaultLbsIncrementForLift:lift.name] ?
                    [settingsStore defaultIncrementForLift:lift.name] : lift.increment;
        }];
    }
}

- (void)addMissingLifts:(NSArray *)liftNames {
    [liftNames each:^(NSString *liftName) {
        SSLift *lift = [[SSLiftStore instance] find:@"name" value:liftName];
        if (!lift) {
            lift = [[SSLiftStore instance] create];
            lift.name = liftName;
            lift.increment = [[SettingsStore instance] defaultIncrementForLift:liftName];
            NSNumber *maxOrder = [[SSLiftStore instance] max:@"order"];
            lift.order = maxOrder != nil ? [NSNumber numberWithInt:[maxOrder intValue] + 1] : @0;
            lift.usesBar = YES;
        }
    }];
}

- (void)removeExtraLifts:(NSArray *)liftNames {
    NSMutableArray *currentNames = [[[self findAll] collect:^id(SSLift *lift) {
        return lift.name;
    }] mutableCopy];
    [currentNames removeObjectsInArray:liftNames];
    [currentNames each:^(NSString *name) {
        [[SSLiftStore instance] remove:[[SSLiftStore instance] find:@"name" value:name]];
    }];
}

@end