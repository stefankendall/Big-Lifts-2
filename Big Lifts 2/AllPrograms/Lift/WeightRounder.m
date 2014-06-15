#import "WeightRounder.h"
#import "JSettings.h"
#import "JSettingsStore.h"
#import "DecimalNumberHandlers.h"

@implementation WeightRounder

- (NSDecimalNumber *)round:(NSDecimalNumber *)number {
    if (number == nil || [number isEqual:[NSDecimalNumber notANumber]]) {
        return N(0);
    }

    JSettings *settings = [[JSettingsStore instance] first];
    if ([settings.roundTo isEqualToNumber:[NSDecimalNumber decimalNumberWithString:NEAREST_5_ROUNDING]]) {
        return [self roundToNearest5:number withDirection:settings.roundingType];
    } else if ([settings.roundTo isEqualToNumber:@5]) {
        return [self roundTo5:number withDirection:settings.roundingType];
    } else if ([settings.roundTo isEqualToNumber:@2.5]) {
        return [self roundTo2p5:number withDirection:settings.roundingType];
    } else if ([settings.roundTo isEqualToNumber:@2]) {
        return [self roundTo2:number withDirection:settings.roundingType];
    } else if ([settings.roundTo isEqualToNumber:@1]) {
        return [self roundTo1:number withDirection:settings.roundingType];
    }
    else {
        return [self roundTo0p5:number withDirection:settings.roundingType];
    }
}

- (NSDecimalNumber *)roundToNearest5:(NSDecimalNumber *)number withDirection:(const NSString *)direction {
    NSDecimalNumber *lastPart = [self getLastPartsOf:number];
    if ([lastPart isEqual:N(5)]) {
        return number;
    }

    if ([direction isEqualToString:(NSString *) ROUNDING_TYPE_UP]) {
        if ([lastPart compare:N(5)] == NSOrderedAscending) {
            return [[number decimalNumberBySubtracting:lastPart] decimalNumberByAdding:N(5)];
        } else {
            return [[number decimalNumberBySubtracting:lastPart] decimalNumberByAdding:N(15)];
        }
    }
    else if ([direction isEqualToString:(NSString *) ROUNDING_TYPE_DOWN]) {
        if ([lastPart compare:N(5)] == NSOrderedAscending) {
            return [[number decimalNumberBySubtracting:lastPart] decimalNumberBySubtracting:N(5)];
        } else {
            return [[number decimalNumberBySubtracting:lastPart] decimalNumberByAdding:N(5)];
        }
    }

    NSDecimalNumber *roundedTo5 = [self roundTo5:number withDirection:ROUNDING_TYPE_NORMAL];
    if ([roundedTo5 intValue] % 10 == 0) {
        NSDecimalNumber *up = [roundedTo5 decimalNumberByAdding:N(3)];
        NSDecimalNumber *down = [roundedTo5 decimalNumberBySubtracting:N(3)];
        NSDecimalNumber *up5 = [self roundTo5:up withDirection:ROUNDING_TYPE_NORMAL];
        NSDecimalNumber *down5 = [self roundTo5:down withDirection:ROUNDING_TYPE_NORMAL];

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

- (NSDecimalNumber *)roundTo1:(NSDecimalNumber *)number withDirection:(const NSString *)direction {
    NSRoundingMode mode = NSRoundPlain;
    if ([direction isEqualToString:(NSString *) ROUNDING_TYPE_UP]) {
        mode = NSRoundUp;
    } else if ([direction isEqualToString:(NSString *) ROUNDING_TYPE_DOWN]) {
        mode = NSRoundDown;
    }

    return [number decimalNumberByRoundingAccordingToBehavior:
            [[NSDecimalNumberHandler alloc] initWithRoundingMode:mode scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO]];
}

- (NSDecimalNumber *)roundTo2:(NSDecimalNumber *)number withDirection:(const NSString *)direction {
    int lastDigitAndDecimalTimes10 = [[number decimalNumberByMultiplyingBy:N(10) withBehavior:DecimalNumberHandlers.noRaise] intValue] % 100;
    while (lastDigitAndDecimalTimes10 >= 20) {
        lastDigitAndDecimalTimes10 -= 20;
    }

    NSDecimalNumber *roundedTo1 = [self roundTo1:number withDirection:ROUNDING_TYPE_NORMAL];
    if (lastDigitAndDecimalTimes10 == 0) {
        return roundedTo1;
    }

    NSDecimalNumber *decimals = [self getDecimalPart:number];
    NSDecimalNumber *numberWithoutDecimals = [number decimalNumberBySubtracting:decimals withBehavior:[DecimalNumberHandlers noRaise]];
    if ([direction isEqualToString:(NSString *) ROUNDING_TYPE_UP]) {
        if ([numberWithoutDecimals intValue] % 2 == 0) {
            return [numberWithoutDecimals decimalNumberByAdding:N(2)];
        }
        else {
            return [numberWithoutDecimals decimalNumberByAdding:N(1)];
        }
    } else if ([direction isEqualToString:(NSString *) ROUNDING_TYPE_DOWN]) {
        if ([numberWithoutDecimals intValue] % 2 == 0) {
            return numberWithoutDecimals;
        }
        else {
            return [numberWithoutDecimals decimalNumberBySubtracting:N(1)];
        }
    }

    if ([roundedTo1 compare:number] == NSOrderedDescending) {
        return [roundedTo1 decimalNumberBySubtracting:N(1)];
    }
    else {
        return [roundedTo1 decimalNumberByAdding:N(1)];
    }
}

- (NSDecimalNumber *)roundTo2p5:(NSDecimalNumber *)number withDirection:(const NSString *)direction {
    NSDecimalNumber *lastDigitAndDecimals = [self getLastPartsOf:number];
    NSDecimalNumber *numberWithoutLastDigits = [number decimalNumberBySubtracting:lastDigitAndDecimals withBehavior:[DecimalNumberHandlers noRaise]];

    if ([lastDigitAndDecimals isEqual:N(2.5)] || [lastDigitAndDecimals isEqual:N(5.0)] || [lastDigitAndDecimals isEqual:N(7.5)]
            || [lastDigitAndDecimals isEqual:N(0)]) {
        return number;
    }

    NSDecimalNumber *roundedNumber = nil;
    if ([lastDigitAndDecimals compare:N(1.25)] == NSOrderedAscending) {
        roundedNumber = numberWithoutLastDigits;
    } else if ([lastDigitAndDecimals compare:N(3.75)] == NSOrderedAscending) {
        roundedNumber = [numberWithoutLastDigits decimalNumberByAdding:N(2.5)];
    } else if ([lastDigitAndDecimals compare:N(6.25)] == NSOrderedAscending) {
        roundedNumber = [numberWithoutLastDigits decimalNumberByAdding:N(5)];
    } else if ([lastDigitAndDecimals compare:N(8.75)] == NSOrderedAscending) {
        roundedNumber = [numberWithoutLastDigits decimalNumberByAdding:N(7.5)];
    } else {
        roundedNumber = [numberWithoutLastDigits decimalNumberByAdding:N(10)];
    }

    if ([direction isEqualToString:(NSString *) ROUNDING_TYPE_UP]) {
        if ([roundedNumber compare:number] == NSOrderedAscending) {
            return [roundedNumber decimalNumberByAdding:N(2.5)];
        }

    } else if ([direction isEqualToString:(NSString *) ROUNDING_TYPE_DOWN]) {
        if ([roundedNumber compare:number] == NSOrderedDescending) {
            return [roundedNumber decimalNumberBySubtracting:N(2.5)];
        }
    }

    return roundedNumber;
}

- (NSDecimalNumber *)roundTo5:(NSDecimalNumber *)number withDirection:(const NSString *)direction {
    int base5Round = [[number decimalNumberByDividingBy:N(5) withBehavior:DecimalNumberHandlers.noRaise] intValue] * 5;

    if ([direction isEqualToString:(NSString *) ROUNDING_TYPE_DOWN]) {
        return [[NSDecimalNumber alloc] initWithInt:base5Round];
    }
    else if ([direction isEqualToString:(NSString *) ROUNDING_TYPE_UP]) {
        NSDecimalNumber *base5 = [[NSDecimalNumber alloc] initWithInt:base5Round];
        if ([base5 isEqualToNumber:number]) {
            return base5;
        }
        else {
            return [base5 decimalNumberByAdding:N(5)];
        }
    }

    int lastDigitAndDecimalTimes10 = [[number decimalNumberByMultiplyingBy:N(10) withBehavior:DecimalNumberHandlers.noRaise] intValue] % 100;
    if (lastDigitAndDecimalTimes10 >= 50) {
        lastDigitAndDecimalTimes10 -= 50;
    }

    if (lastDigitAndDecimalTimes10 == 0) {
        return [self roundTo1:number withDirection:ROUNDING_TYPE_NORMAL];
    }
    else if (lastDigitAndDecimalTimes10 < 25) {
        return [[NSDecimalNumber alloc] initWithInt:base5Round];
    }
    else {
        return [[NSDecimalNumber alloc] initWithInt:base5Round + 5];
    }
}

- (NSDecimalNumber *)roundTo0p5:(NSDecimalNumber *)number withDirection:(NSString <Optional> *)direction {
    NSDecimalNumber *numberTimes10 = [number decimalNumberByMultiplyingBy:N(10) withBehavior:[DecimalNumberHandlers noRaise]];
    NSDecimalNumber *rounded = [self roundTo5:numberTimes10 withDirection:direction];
    return [rounded decimalNumberByDividingBy:N(10) withBehavior:[DecimalNumberHandlers noRaise]];
}

- (NSDecimalNumber *)getLastPartsOf:(NSDecimalNumber *)number {
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *wholeNumbers = [number decimalNumberByRoundingAccordingToBehavior:behavior];
    NSDecimalNumber *decimals = [number decimalNumberBySubtracting:wholeNumbers withBehavior:DecimalNumberHandlers.noRaise];
    int lastDigit = [wholeNumbers intValue] % 10;
    NSDecimalNumber *lastDigitDecimal = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInteger:lastDigit] decimalValue]];
    return [lastDigitDecimal decimalNumberByAdding:decimals withBehavior:DecimalNumberHandlers.noRaise];
}

- (NSDecimalNumber *)getDecimalPart:(NSDecimalNumber *)number {
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *wholeNumbers = [number decimalNumberByRoundingAccordingToBehavior:behavior];
    return [number decimalNumberBySubtracting:wholeNumbers withBehavior:DecimalNumberHandlers.noRaise];
}

@end