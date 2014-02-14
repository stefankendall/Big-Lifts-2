#import "WeightUnitsTests.h"
#import "WeightUnits.h"

@implementation WeightUnitsTests

- (void)testConvertsLbsToKg {
    STAssertEqualObjects([WeightUnits lbsToKg: nil], N(0), @"");
    STAssertEqualObjects([WeightUnits lbsToKg: N(0)], N(0), @"");
    STAssertEqualObjects([WeightUnits lbsToKg: N(10)], N(4.53592), @"");
}

@end