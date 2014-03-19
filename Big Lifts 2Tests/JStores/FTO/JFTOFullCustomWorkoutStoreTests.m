#import "JFTOFullCustomWorkoutStoreTests.h"
#import "JFTOFullCustomWorkoutStore.h"
#import "JFTOLiftStore.h"

@implementation JFTOFullCustomWorkoutStoreTests

- (void)testSetsUpData {
    STAssertEquals([[JFTOFullCustomWorkoutStore instance] count], 16, @"");
}

- (void)testAdjustToFtoLifts {
    [[JFTOLiftStore instance] removeAtIndex:0];
    STAssertEquals([[JFTOFullCustomWorkoutStore instance] count], 12, @"");
    [[JFTOLiftStore instance] create];
    STAssertEquals([[JFTOFullCustomWorkoutStore instance] count], 16, @"");
}

@end