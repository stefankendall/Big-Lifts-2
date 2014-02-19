#import "WeightUnits.h"

@implementation WeightUnits

+ (NSDecimalNumber *)lbsToKg:(NSDecimalNumber *)lbs {
    if (lbs == nil || [lbs isEqual:[NSDecimalNumber notANumber]]) {
        return N(0);
    }

    return [lbs decimalNumberByMultiplyingBy:N(0.453592)];
}

@end