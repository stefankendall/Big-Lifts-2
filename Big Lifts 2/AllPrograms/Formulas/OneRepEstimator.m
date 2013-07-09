#import "OneRepEstimator.h"

@implementation OneRepEstimator

- (NSDecimalNumber *)estimate:(NSDecimalNumber *)weight withReps:(int)reps {
    if (reps <= 1) {
        return weight;
    }

    NSDecimalNumber *add = [[weight decimalNumberByMultiplyingBy:N(0.033)] decimalNumberByMultiplyingBy:
            [[NSDecimalNumber alloc] initWithInt:reps]];

    return [weight decimalNumberByAdding:add];
}

@end