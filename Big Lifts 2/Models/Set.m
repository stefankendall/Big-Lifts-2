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

    Bar *bar = [[BarStore instance] first];
    NSDecimalNumber *effectiveWeight = [[self.lift.weight decimalNumberByMultiplyingBy:self.percentage]
            decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];

    if([effectiveWeight compare:bar.weight] == NSOrderedAscending){
        return bar.weight;
    }

    return effectiveWeight;
}

- (NSDecimalNumber *)roundedEffectiveWeight {
    return [[WeightRounder new] round:[self effectiveWeight]];
}

@end