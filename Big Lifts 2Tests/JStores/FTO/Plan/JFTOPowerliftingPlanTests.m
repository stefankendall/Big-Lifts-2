#import "JFTOPowerliftingPlanTests.h"
#import "JFTOPowerliftingPlan.h"
#import "JSetData.h"

@implementation JFTOPowerliftingPlanTests

- (void)testGeneratesPowerliftingPlan {
    NSDictionary *sets = [[JFTOPowerliftingPlan new] generate:nil];
    JSetData *data = [sets[@1] lastObject];
    STAssertEquals(data.reps, 3, @"");
}

- (void)testWeek2HasNoAmrap {
    NSDictionary *sets = [[JFTOPowerliftingPlan new] generate:nil];
    JSetData *data = [sets[@2] lastObject];
    STAssertFalse(data.amrap, @"");
}

@end