#import "Set.h"
#import "Lift.h"
#import "WeightRounder.h"
#import "BarStore.h"
#import "Bar.h"

@implementation Set

- (NSDecimalNumber *)effectiveWeight {
    if (!self.percentage) {
        return self.weight;
    }

    if ([self.percentage isEqualToNumber:@0]) {
        Bar *bar = [[BarStore instance] first];
        return bar.weight;
    }

    return [[self.lift.weight decimalNumberByMultiplyingBy:self.percentage]
            decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
}

- (NSDecimalNumber *)roundedEffectiveWeight {
    return [[WeightRounder new] round:[self effectiveWeight]];
}

@end