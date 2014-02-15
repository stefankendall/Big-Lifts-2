#import "WilksCoefficientCalculator.h"
#import "WeightUnits.h"

@implementation WilksCoefficientCalculator

+ (NSDecimalNumber *)calculate:(NSDecimalNumber *)weight withBodyweight:(NSDecimalNumber *)bodyweight isMale:(BOOL)isMale withUnits:(NSString *)units {
    if (weight == nil || bodyweight == nil ) {
        return N(0);
    }

    NSDictionary *k = isMale ? @{
            @"a" : N(-216.0475144),
            @"b" : N(16.2606339),
            @"c" : N(-0.002388645),
            @"d" : N(-0.00113732),
            @"e" : N(0.00000701863),
            @"f" : N(-0.00000001291)
    } : @{
            @"a" : N(594.31747775582),
            @"b" : N(-27.23842536447),
            @"c" : N(0.82112226871),
            @"d" : N(-0.00930733913),
            @"e" : N(0.00004731582),
            @"f" : N(-0.00000009054)
    };
    NSDecimalNumber *convertedBodyweight = [units isEqualToString:@"kg"] ? bodyweight : [WeightUnits lbsToKg:bodyweight];
    NSArray *terms = @[
            k[@"a"],
            [k[@"b"] decimalNumberByMultiplyingBy:convertedBodyweight],
            [k[@"c"] decimalNumberByMultiplyingBy:[convertedBodyweight decimalNumberByRaisingToPower:2]],
            [k[@"d"] decimalNumberByMultiplyingBy:[convertedBodyweight decimalNumberByRaisingToPower:3]],
            [k[@"e"] decimalNumberByMultiplyingBy:[convertedBodyweight decimalNumberByRaisingToPower:4]],
            [k[@"f"] decimalNumberByMultiplyingBy:[convertedBodyweight decimalNumberByRaisingToPower:5]]
    ];

    NSDecimalNumber *denominator = N(0);
    for (NSDecimalNumber *term in terms) {
        denominator = [denominator decimalNumberByAdding:term];
    }

    NSDecimalNumber *coefficient = [N(500) decimalNumberByDividingBy:denominator];
    NSDecimalNumber *convertedLiftedWeight = [units isEqualToString:@"kg"] ? weight : [WeightUnits lbsToKg:weight];
    return [[coefficient decimalNumberByMultiplyingBy:convertedLiftedWeight] decimalNumberByRoundingAccordingToBehavior:
            [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:3 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO]
    ];
}

@end