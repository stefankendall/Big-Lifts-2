#import "JSet.h"
#import "WeightRounder.h"
#import "JBar.h"
#import "JLift.h"
#import "JBarStore.h"
#import "DecimalNumberHandlers.h"

@implementation JSet

- (NSDecimalNumber *)effectiveWeight {
    if (!self.percentage || !self.lift) {
        return N(0);
    }

    NSDecimalNumber *effectiveWeight;
    effectiveWeight = [[self.lift.weight decimalNumberByMultiplyingBy:self.percentage withBehavior:DecimalNumberHandlers.noRaise]
            decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100" locale:NSLocale.currentLocale] withBehavior:DecimalNumberHandlers.noRaise];

    if (self.lift.usesBar) {
        JBar *bar = [[JBarStore instance] first];
        if (!effectiveWeight || [effectiveWeight compare:bar.weight] == NSOrderedAscending) {
            return bar.weight;
        }
    }

    return effectiveWeight == nil ? N(0) : effectiveWeight;
}

- (NSDecimalNumber *)roundedEffectiveWeight {
    return [[WeightRounder new] round:[self effectiveWeight]];
}

@end