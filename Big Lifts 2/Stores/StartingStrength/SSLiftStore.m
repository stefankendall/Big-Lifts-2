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
        [self createLift:@"Bench" withOrder:0 withIncrement:5];
        [self createLift:@"Deadlift" withOrder:1 withIncrement:10];
        [self createLift:@"Power Clean" withOrder:2 withIncrement:5];
        [self createLift:@"Press" withOrder:3 withIncrement:5];
        [self createLift:@"Squat" withOrder:4 withIncrement:10];
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
    Settings *settings = [[SettingsStore instance] first];
    if ([settings.units isEqualToString:@"kg"]) {
        SSLift *bench = [[SSLiftStore instance] find:@"name" value:@"Bench"];
        SSLift *squat = [[SSLiftStore instance] find:@"name" value:@"Squat"];
        SSLift *deadlift = [[SSLiftStore instance] find:@"name" value:@"Deadlift"];
        SSLift *powerClean = [[SSLiftStore instance] find:@"name" value:@"Power Clean"];
        SSLift *press = [[SSLiftStore instance] find:@"name" value:@"Press"];

        bench.increment = [bench.increment doubleValue] == 5.0 ? [self defaultIncrementForLift:@"Bench"]
                : bench.increment;
        squat.increment = [bench.increment doubleValue] == 10.0 ? [self defaultIncrementForLift:@"Squat"]
                : squat.increment;
        deadlift.increment = [bench.increment doubleValue] == 10.0 ? [self defaultIncrementForLift:@"Deadlift"]
                : deadlift.increment;
        powerClean.increment = [bench.increment doubleValue] == 5.0 ? [self defaultIncrementForLift:@"Power Clean"]
                : powerClean.increment;
        press.increment = [bench.increment doubleValue] == 5.0 ? [self defaultIncrementForLift:@"Press"]
                : press.increment;
    }
}

- (void)addMissingLifts:(NSArray *)liftNames {
    [liftNames each:^(NSString *liftName) {
        SSLift *lift = [[SSLiftStore instance] find:@"name" value:liftName];
        if (!lift) {
            lift = [[SSLiftStore instance] create];
            lift.name = liftName;
            lift.increment = [self defaultIncrementForLift:liftName];
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

- (NSDecimalNumber *)defaultIncrementForLift:(NSString *)liftName {
    NSDictionary *defaultIncrements = @{
            @"Press" : @5,
            @"Bench" : @5,
            @"Power Clean" : @5,
            @"Deadlift" : @10,
            @"Squat" : @10,
            @"Back Extension" : @0
    };

    NSDecimalNumber *increment = defaultIncrements[liftName];
    Settings *settings = [[SettingsStore instance] first];
    if ([settings.units isEqualToString:@"kg"]) {
        if ([increment intValue] == 5) {
            increment = [NSDecimalNumber decimalNumberWithString:@"2"];
        }
        else if ([increment intValue] == 10) {
            increment = [NSDecimalNumber decimalNumberWithString:@"5"];
        }
    }
    return increment;
}

@end