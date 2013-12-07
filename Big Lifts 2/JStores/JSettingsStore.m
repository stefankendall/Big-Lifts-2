#import "JSettingsStore.h"
#import "JSettings.h"

@implementation JSettingsStore

- (Class)modelClass {
    return JSettings.class;
}

- (void)onLoad {
    JSettings *settings = [self first];
    [[UIApplication sharedApplication] setIdleTimerDisabled:settings.screenAlwaysOn];
}

- (void)setupDefaults {
    JSettings *settings = [self create];
    [settings setUnits:@"lbs"];
    [settings setRoundTo:N(5)];
    settings.screenAlwaysOn = NO;
    settings.roundingFormula = (NSString *) ROUNDING_FORMULA_EPLEY;
}

- (void)adjustForKg {
    JSettings *settings = [self first];
    if ([settings.units isEqualToString:@"kg"]) {
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
            @"Press" : N(5),
            @"Bench" : N(5),
            @"Power Clean" : N(5),
            @"Deadlift" : N(10),
            @"Squat" : N(10),
            @"Back Extension" : N(0)
    };

    return defaultIncrements[liftName];
}

@end