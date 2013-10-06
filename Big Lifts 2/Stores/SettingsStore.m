#import "SettingsStore.h"
#import "Settings.h"

@implementation SettingsStore

- (void)setupDefaults {
    Settings *settings = [self create];
    [settings setUnits:@"lbs"];
    [settings setRoundTo:[NSDecimalNumber decimalNumberWithString:@"5"]];
    settings.roundingFormula = (NSString *) ROUNDING_FORMULA_EPLEY;
}

- (void)onLoad {
    [[SettingsStore instance] registerChangeListener:^{
        [self adjustForKg];
    }];
}

- (void)adjustForKg {
    Settings *settings = [[SettingsStore instance] first];
    if ([settings.units isEqualToString:@"kg"] && [settings.roundTo isEqualToNumber:@5]) {
        settings.roundTo = [NSDecimalNumber decimalNumberWithString:@"1"];
    }
}

- (NSDecimalNumber *)defaultIncrementForLift:(NSString *)liftName {
    NSDecimalNumber *increment = [self defaultLbsIncrementForLift:liftName];
    Settings *settings = [self first];
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