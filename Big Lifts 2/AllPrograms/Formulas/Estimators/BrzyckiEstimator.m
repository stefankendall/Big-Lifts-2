#import "BrzyckiEstimator.h"

@implementation BrzyckiEstimator

- (NSDecimalNumber *)estimate:(NSDecimalNumber *)weight withReps:(int)reps {
    if (reps >= 37) {
        return N(0);
    }

    NSDecimalNumber *numerator = [weight decimalNumberByMultiplyingBy:N(36)];
    NSDecimalNumber *denominator = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:(37 - reps)] decimalValue]];
    return [numerator decimalNumberByDividingBy:denominator];
}

@end