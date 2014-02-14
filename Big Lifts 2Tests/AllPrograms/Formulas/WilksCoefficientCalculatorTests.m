#import "WilksCoefficientCalculatorTests.h"
#import "WilksCoefficientCalculator.h"

@implementation WilksCoefficientCalculatorTests

- (void)testCalculatesWilks {
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(170) isMale:YES withUnits:@"kg"], N(162.93), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(150) isMale:YES withUnits:@"kg"], N(165.99), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(200) withBodyweight:N(150) isMale:YES withUnits:@"kg"], N(110.66), @"");
}

- (void)testCalculatesWilksLbs {
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(170) isMale:YES withUnits:@"lbs"], N(95.146), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(150) isMale:YES withUnits:@"lbs"], N(104.249), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(200) withBodyweight:N(150) isMale:YES withUnits:@"lbs"], N(69.499), @"");
}

- (void)testCalculatesForFemale {
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(170) isMale:NO withUnits:@"kg"], N(237.9), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(300) withBodyweight:N(150) isMale:NO withUnits:@"kg"], N(230.85), @"");
    STAssertEqualObjects([WilksCoefficientCalculator calculate:N(200) withBodyweight:N(150) isMale:NO withUnits:@"kg"], N(153.9), @"");
}

@end