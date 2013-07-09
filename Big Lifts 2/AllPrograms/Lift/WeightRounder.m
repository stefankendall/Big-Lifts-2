#import "WeightRounder.h"
#import "Settings.h"
#import "SettingsStore.h"

@implementation WeightRounder

- (NSDecimalNumber *)round:(NSDecimalNumber *)number {
    Settings *settings = [[SettingsStore instance] first];
    if ([settings.roundTo isEqualToNumber:@5]) {
        return [self roundTo5:number];
    }
    else {
        return [self roundTo1:number];
    }
}

- (NSDecimalNumber *)roundTo1:(NSDecimalNumber *)number {
    return [number decimalNumberByRoundingAccordingToBehavior:
            [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO]];
}

- (NSDecimalNumber *)roundTo5:(NSDecimalNumber *)number {
    int base5Round = [[number decimalNumberByDividingBy:N(5)] intValue] * 5;
    int lastTwoDigits = [[number decimalNumberByMultiplyingBy:N(10)] intValue] % 100;
    lastTwoDigits = lastTwoDigits >= 50 ? lastTwoDigits - 50 : lastTwoDigits;

    if (lastTwoDigits == 0) {
        return number;
    }
    else if (lastTwoDigits < 25) {
        return [[NSDecimalNumber alloc] initWithInt:base5Round];
    }
    else {
        return [[NSDecimalNumber alloc] initWithInt:base5Round + 5];
    }
}

@end