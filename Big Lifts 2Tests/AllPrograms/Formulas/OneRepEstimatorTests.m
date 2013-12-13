#import "OneRepEstimatorTests.h"
#import "OneRepEstimator.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation OneRepEstimatorTests

- (void)testEstimatesOneRepMax {
    STAssertEqualObjects([[OneRepEstimator new] estimate:N(200) withReps:6], N(240), @"");
    STAssertEqualObjects([[OneRepEstimator new] estimate:N(200) withReps:1], N(200), @"");
    STAssertEqualObjects([[OneRepEstimator new] estimate:N(100) withReps:5], N(116.7), @"");
}

- (void)testHandlesNilWeight {
    STAssertEqualObjects([[OneRepEstimator new] estimate:nil withReps:5], nil, @"");
}

- (void)testReturns0ForOverflowAndDoesNotCrash {
    STAssertEqualObjects([[OneRepEstimator new] estimate:N(NSIntegerMax) withReps:NSIntegerMax], [NSDecimalNumber notANumber], @"");
}

- (void)testCutsNumbersToOneDecimalPlace {
    STAssertEqualObjects([[OneRepEstimator new] oneDecimalPlace:N(200.6666)], N(200.7), @"");
}

- (void)testUsesSavedFormula {
    [[[JSettingsStore instance] first] setRoundingFormula:(NSString *) ROUNDING_FORMULA_BRZYCKI];
    STAssertEqualObjects([[OneRepEstimator new] estimate:N(100) withReps:5], N(112.5), @"");
}

@end