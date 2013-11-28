#import "JSet.h"
#import "WeightRounder.h"
#import "JBar.h"
#import "JLift.h"
#import "JBarStore.h"

@implementation JSet

- (NSDecimalNumber *)effectiveWeight {
    NSDecimalNumber *effectiveWeight;
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                             scale:NSDecimalNoScale
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:NO];
    effectiveWeight = [[self.lift.weight decimalNumberByMultiplyingBy:self.percentage withBehavior:handler]
            decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100" locale:NSLocale.currentLocale] withBehavior:handler];

    if (self.lift.usesBar) {
        JBar *bar = [[JBarStore instance] first];
        if (!effectiveWeight || [effectiveWeight compare:bar.weight] == NSOrderedAscending) {
            return bar.weight;
        }
    }

    return effectiveWeight;
}

- (NSDecimalNumber *)roundedEffectiveWeight {
    return [[WeightRounder new] round:[self effectiveWeight]];
}

- (BOOL)hasVariableReps {
    return [self amrap] || [[self maxReps] intValue] > 0;
}

@end