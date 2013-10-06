#import "OneRepEstimator.h"

@implementation OneRepEstimator

- (NSDecimalNumber *)estimate:(NSDecimalNumber *)weight withReps:(int)reps {
    if (reps == 1) {
        return weight;
    }
    else if (reps == 0) {
        return N(0);
    }

    NSDecimalNumber *repsDecimal = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInteger:reps] decimalValue]];
    NSDecimalNumber *factor = [N(1) decimalNumberByAdding:[repsDecimal decimalNumberByDividingBy:N(30)]];
    return [self oneDecimalPlace:[weight decimalNumberByMultiplyingBy:factor]];
}

- (NSDecimalNumber *)oneDecimalPlace:(NSDecimalNumber *)number {
    NSDecimalNumberHandler *handler =
            [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain scale:1 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    return [number decimalNumberByRoundingAccordingToBehavior:handler];
}

@end