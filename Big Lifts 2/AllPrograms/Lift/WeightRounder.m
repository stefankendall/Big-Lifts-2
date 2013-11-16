#import "WeightRounder.h"
#import "Settings.h"
#import "SettingsStore.h"

@implementation WeightRounder

- (NSDecimalNumber *)round:(NSDecimalNumber *)number {
    Settings *settings = [[SettingsStore instance] first];
    if ([settings.roundTo isEqualToNumber:[NSDecimalNumber decimalNumberWithString:NEAREST_5_ROUNDING]]) {
        return [self roundToNearest5:number];
    }
    else if ([settings.roundTo isEqualToNumber:@5]) {
        return [self roundTo5:number];
    }
    else if ([settings.roundTo isEqualToNumber:@2.5]) {
        return [self roundTo2p5:number];
    } else {
        return [self roundTo1:number];
    }
}

- (NSDecimalNumber *)roundToNearest5:(NSDecimalNumber *)number {
    NSDecimalNumber *roundedTo5 = [self roundTo5:number];
    if ([roundedTo5 intValue] % 10 == 0) {
        NSDecimalNumber *up = [roundedTo5 decimalNumberByAdding:N(3)];
        NSDecimalNumber *down = [roundedTo5 decimalNumberBySubtracting:N(3)];
        NSDecimalNumber *up5 = [self roundTo5:up];
        NSDecimalNumber *down5 = [self roundTo5:down];

        NSDecimalNumber *upDistance = [up5 decimalNumberBySubtracting:number];
        NSDecimalNumber *downDistance = [number decimalNumberBySubtracting:down5];

        NSComparisonResult upToDown = [upDistance compare:downDistance];
        if (upToDown == NSOrderedAscending || upToDown == NSOrderedSame) {
            return up5;
        }
        else {
            return down5;
        }
    }
    else {
        return roundedTo5;
    }
}

- (NSDecimalNumber *)roundTo1:(NSDecimalNumber *)number {
    return [number decimalNumberByRoundingAccordingToBehavior:
            [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO]];
}

- (NSDecimalNumber *)roundTo2p5:(NSDecimalNumber *)number {
    NSDecimalNumber *lastDigitAndDecimals = [self getLastPartsOf:number];
    NSDecimalNumber *numberWithoutLastDigits = [number decimalNumberBySubtracting:lastDigitAndDecimals];

    if ([lastDigitAndDecimals compare:N(1.25)] == NSOrderedAscending) {
        return numberWithoutLastDigits;
    }
    else if ([lastDigitAndDecimals compare:N(3.75)] == NSOrderedAscending) {
        return [numberWithoutLastDigits decimalNumberByAdding:N(2.5)];
    }
    else if ([lastDigitAndDecimals compare:N(6.25)] == NSOrderedAscending) {
        return [numberWithoutLastDigits decimalNumberByAdding:N(5)];
    }
    else if ([lastDigitAndDecimals compare:N(8.75)] == NSOrderedAscending) {
        return [numberWithoutLastDigits decimalNumberByAdding:N(7.5)];
    }
    else {
        return [numberWithoutLastDigits decimalNumberByAdding:N(10)];
    }
}

- (NSDecimalNumber *)getLastPartsOf:(NSDecimalNumber *)number {
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *wholeNumbers = [number decimalNumberByRoundingAccordingToBehavior:behavior];
    NSDecimalNumber *decimals = [number decimalNumberBySubtracting:wholeNumbers];
    int lastDigit = [wholeNumbers intValue] % 10;
    NSDecimalNumber *lastDigitDecimal = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInteger:lastDigit] decimalValue]];
    return [lastDigitDecimal decimalNumberByAdding:decimals];
}

- (NSDecimalNumber *)roundTo5:(NSDecimalNumber *)number {
    int base5Round = [[number decimalNumberByDividingBy:N(5)] intValue] * 5;
    int lastTwoDigits = [[number decimalNumberByMultiplyingBy:N(10)] intValue] % 100;
    if (lastTwoDigits >= 50) {
        lastTwoDigits -= 50;
    }

    if (lastTwoDigits == 0) {
        return [self roundTo1:number];
    }
    else if (lastTwoDigits < 25) {
        return [[NSDecimalNumber alloc] initWithInt:base5Round];
    }
    else {
        return [[NSDecimalNumber alloc] initWithInt:base5Round + 5];
    }
}

@end