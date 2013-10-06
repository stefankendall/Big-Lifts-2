#import "OneRepEstimatorTests.h"
#import "OneRepEstimator.h"

@implementation OneRepEstimatorTests

- (void) testEstimatesOneRepMax {
    STAssertEqualObjects([[OneRepEstimator new] estimate:N(200) withReps:6], N(240), @"");
    STAssertEqualObjects([[OneRepEstimator new] estimate:N(200) withReps:1], N(200), @"");
    STAssertEqualObjects([[OneRepEstimator new] estimate:N(100) withReps:5], N(116.7), @"");
}

- (void) testCutsNumbersToOneDecimalPlace {
    STAssertEqualObjects([[OneRepEstimator new] oneDecimalPlace:N(200.6666)], N(200.7), @"");
}

@end