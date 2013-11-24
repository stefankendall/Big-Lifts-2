#import "JSettingsStore.h"
#import "JSettings.h"
#import "Settings.h"

@implementation JSettingsStore

- (Class)modelClass {
    return JSettings.class;
}

- (void)setupDefaults {
    JSettings *settings = [self create];
    [settings setUnits:@"lbs"];
    [settings setRoundTo:N(5)];
    settings.roundingFormula = (NSString *) ROUNDING_FORMULA_EPLEY;
}

- (void)adjustForKg {
    JSettings *settings = [self first];
    if ([settings.units isEqualToString:@"kg"] && [settings.roundTo isEqualToNumber:@5]) {
        settings.roundTo = N(1);
    }
}

- (NSDecimalNumber *)defaultIncrementForLift:(NSString *)liftName {
    NSDecimalNumber *increment = [self defaultLbsIncrementForLift:liftName];
    JSettings *settings = [self first];
    if ([settings.units isEqualToString:@"kg"]) {
        if ([increment intValue] == 5) {
            increment = N(2);
        }
        else if ([increment intValue] == 10) {
            increment = N(5);
        }
    }
    return increment;
}

- (NSDecimalNumber *)defaultLbsIncrementForLift:(NSString *)liftName {
    NSDictionary *defaultIncrements = @{
            @"Press" : @5,
            @"Bench" : @5,
            @"Power Clean" : @5,
            @"Deadlift" : @10,
            @"Squat" : @10,
            @"Back Extension" : @0
    };

    return defaultIncrements[liftName];
}

@end