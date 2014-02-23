#import "WilksCoefficientCalculatorTests.h"
#import "WilksCoefficientCalculator.h"

@implementation WilksCoefficientCalculatorTests

- (void)testCalculatesWilks {
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(170) isMale:YES withUnits:@"kg"], N(162.943), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(150) isMale:YES withUnits:@"kg"], N(165.989), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(200) withBodyweight:N(150) isMale:YES withUnits:@"kg"], N(110.659), @"");
}

- (void)testCalculatesWilksLbs {
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(170) isMale:YES withUnits:@"lbs"], N(95.145), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(150) isMale:YES withUnits:@"lbs"], N(104.256), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(200) withBodyweight:N(150) isMale:YES withUnits:@"lbs"], N(69.504), @"");
}

- (void)testCalculatesForFemale {
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(170) isMale:NO withUnits:@"kg"], N(237.898), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(150) isMale:NO withUnits:@"kg"], N(230.845), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(200) withBodyweight:N(150) isMale:NO withUnits:@"kg"], N(153.896), @"");
}

- (void)testDoesNotCrashBoundaryValues {
    [WilksCoefficientCalculator calculate:nil withBodyweight:nil isMale:NO withUnits:@"kg"];
    [WilksCoefficientCalculator calculate:nil withBodyweight:nil isMale:NO withUnits:@"lbs"];
    [WilksCoefficientCalculator calculate:nil withBodyweight:nil isMale:YES withUnits:@"lbs"];
    [WilksCoefficientCalculator calculate:nil withBodyweight:[NSDecimalNumber notANumber] isMale:YES withUnits:@"lbs"];
    [WilksCoefficientCalculator calculate:N(0) withBodyweight:N(0) isMale:YES withUnits:@"lbs"];
}

@end