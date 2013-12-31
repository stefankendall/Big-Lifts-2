#import "JFTOPowerliftingPlanTests.h"
#import "JFTOPowerliftingPlan.h"
#import "JSetData.h"

@implementation JFTOPowerliftingPlanTests

- (void)testGeneratesPowerliftingPlan {
    NSDictionary *sets = [[JFTOPowerliftingPlan new] generate:nil];
    JSetData *data = [sets[@1] lastObject];
    STAssertEquals(data.reps, 3, @"");
}

@end