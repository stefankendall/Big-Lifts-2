#import "FTOLiftIncrementerTests.h"
#import "JFTOSSTLift.h"
#import "JFTOSSTLiftStore.h"
#import "FTOLiftIncrementer.h"

@implementation FTOLiftIncrementerTests

- (void)testIncrementsSst {
    JFTOSSTLift *firstLift = [[JFTOSSTLiftStore instance] first];
    NSDecimalNumber *weight = firstLift.weight;

    [[FTOLiftIncrementer new] incrementLifts];

    STAssertFalse([weight isEqual:firstLift.weight], @"");
}

@end