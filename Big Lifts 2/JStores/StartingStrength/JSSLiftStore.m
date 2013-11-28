#import "JSSLiftStore.h"
#import "JSSLift.h"
#import "NSArray+Enumerable.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation JSSLiftStore

- (Class)modelClass {
    return JSSLift.class;
}

- (void)setupDefaults {
    [self addMissingLifts:@[@"Bench", @"Deadlift", @"Power Clean", @"Press", @"Squat"]];
}

- (void)createLift:(NSString *)name withOrder:(double)order withIncrement:(int)increment {
    JSSLift *lift = [self create];
    [lift setName:name];
    [lift setOrder:[NSNumber numberWithDouble:order]];
    [lift setIncrement:[NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:increment] decimalValue]]];
}

- (void)adjustForKg {
    JSettingsStore *settingsStore = [JSettingsStore instance];
    NSArray *liftNames = [[self findAll] collect:^id(JLift *lift) {
        return lift.name;
    }];
    [liftNames each:^(NSString *liftName) {
        JSSLift *lift = [[JSSLiftStore instance] find:@"name" value:liftName];
        lift.increment = [settingsStore defaultLbsIncrementForLift:lift.name] ?
                [settingsStore defaultIncrementForLift:lift.name] : lift.increment;
    }];
}

- (void)addMissingLifts:(NSArray *)liftNames {
    [liftNames each:^(NSString *liftName) {
        JSSLift *lift = [[JSSLiftStore instance] find:@"name" value:liftName];
        if (!lift) {
            lift = [[JSSLiftStore instance] create];
            lift.name = liftName;
            lift.increment = [[JSettingsStore instance] defaultIncrementForLift:liftName];
            NSNumber *maxOrder = [[JSSLiftStore instance] max:@"order"];
            lift.order = maxOrder != nil ? [NSNumber numberWithInt:[maxOrder intValue] + 1] : @0;
            lift.usesBar = YES;
        }
    }];
}

- (void)removeExtraLifts:(NSArray *)liftNames {
    NSMutableArray *currentNames = [[[self findAll] collect:^id(JSSLift *lift) {
        return lift.name;
    }] mutableCopy];
    [currentNames removeObjectsInArray:liftNames];
    [currentNames each:^(NSString *name) {
        [[JSSLiftStore instance] remove:[[JSSLiftStore instance] find:@"name" value:name]];
    }];
}

@end