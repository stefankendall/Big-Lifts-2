#import "OneRepEstimator.h"

@implementation OneRepEstimator

- (NSDecimalNumber *)estimate:(NSDecimalNumber *)weight withReps:(int)reps {
    NSDecimalNumber *add = [[weight decimalNumberByMultiplyingBy:N(0.033)] decimalNumberByMultiplyingBy:
            [[NSDecimalNumber alloc] initWithInt:reps]];

    return [weight decimalNumberByAdding:add];
}

@end