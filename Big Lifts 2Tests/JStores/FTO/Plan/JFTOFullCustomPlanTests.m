#import "JFTOFullCustomPlanTests.h"
#import "JFTOFullCustomPlan.h"

@implementation JFTOFullCustomPlanTests

- (void)testHasData {
    JFTOFullCustomPlan *plan = [JFTOFullCustomPlan new];
    STAssertNotNil([plan deloadWeeks], @"");
    STAssertNotNil([plan weekNames], @"");
    STAssertNotNil([plan incrementMaxesWeeks], @"");
    STAssertNotNil([plan generate:nil], @"");
}

@end