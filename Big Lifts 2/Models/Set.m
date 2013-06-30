#import "Set.h"
#import "Lift.h"

@implementation Set

- (NSDecimalNumber *)effectiveWeight {
    if (!self.percentage) {
        return self.weight;
    }

    return [[self.lift.weight decimalNumberByMultiplyingBy:self.percentage]
            decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
}

@end