#import "Set.h"
#import "Lift.h"
#import "WeightRounder.h"
#import "BarStore.h"
#import "Bar.h"

@implementation Set

- (NSDecimalNumber *)effectiveWeight {
    NSDecimalNumber *effectiveWeight;
    if (!self.percentage) {
        effectiveWeight = self.weight;
    }
    else {
        effectiveWeight = [[self.lift.weight decimalNumberByMultiplyingBy:self.percentage]
                decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    }

    Bar *bar = [[BarStore instance] first];
    if ([effectiveWeight compare:bar.weight] == NSOrderedAscending) {
        return bar.weight;
    }

    return effectiveWeight;
}

- (NSDecimalNumber *)roundedEffectiveWeight {
    return [[WeightRounder new] round:[self effectiveWeight]];
}

@end