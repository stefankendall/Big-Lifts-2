#import "Set.h"
#import "Lift.h"
#import "WeightRounder.h"

@implementation Set

- (NSDecimalNumber *)effectiveWeight {
    if (!self.percentage) {
        return self.weight;
    }

    return [[self.lift.weight decimalNumberByMultiplyingBy:self.percentage]
            decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
}

- (NSDecimalNumber *)roundedEffectiveWeight {
    return [[WeightRounder new] round:[self effectiveWeight]];
}

@end