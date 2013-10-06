#import "EpleyEstimator.h"

@implementation EpleyEstimator

- (NSDecimalNumber *)estimate:(NSDecimalNumber *)weight withReps:(int)reps {
    NSDecimalNumber *repsDecimal = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInteger:reps] decimalValue]];
    NSDecimalNumber *factor = [N(1) decimalNumberByAdding:[repsDecimal decimalNumberByDividingBy:N(30)]];
    return [weight decimalNumberByMultiplyingBy:factor];
}

@end