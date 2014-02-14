#import "WilksCoefficientCalculator.h"
#import "WeightUnits.h"

@implementation WilksCoefficientCalculator

+ (NSDecimalNumber *)calculate:(NSDecimalNumber *)weight withBodyweight:(NSDecimalNumber *)bodyweight isMale:(BOOL)isMale withUnits: (NSString *) units {
    if (weight == nil || bodyweight == nil ) {
        return N(0);
    }

    NSDecimalNumber *liftedWeight = [units isEqualToString:@"kg"] ? weight : [WeightUnits lbsToKg:weight];
    NSDictionary *coefficients = isMale ? @{
            @"a": N(-216.0475144),
            @"b": N(16.2606339),
            @"c": N(-0.002388645),
            @"d": N(-0.00113732),
            @"e": N(0.00000701863),
            @"f": N(-0.00000001291)
    } : @{
            @"a": N(594.31747775582),
            @"b": N(-27.23842536447),
            @"c": N(0.82112226871),
            @"d": N(-0.00930733913),
            @"e": N(0.00004731582),
            @"f": N(-0.00000009054)
    };
    return liftedWeight;
}

@end