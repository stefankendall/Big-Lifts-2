#import "EpleyEstimator.h"
#import "DecimalNumberHandlers.h"

@implementation EpleyEstimator

- (NSDecimalNumber *)estimate:(NSDecimalNumber *)weight withReps:(int)reps {
    NSDecimalNumber *repsDecimal = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInteger:reps] decimalValue]];
    NSDecimalNumber *factor = [N(1) decimalNumberByAdding:[repsDecimal decimalNumberByDividingBy:N(30)] withBehavior:DecimalNumberHandlers.noRaise];
    return [weight decimalNumberByMultiplyingBy:factor withBehavior:DecimalNumberHandlers.noRaise];
}

@end