#import "JFTOCustomPlanTests.h"
#import "JFTOCustomWorkout.h"
#import "JFTOCustomWorkoutStore.h"
#import "JFTOCustomPlan.h"

@implementation JFTOCustomPlanTests

- (void)testMarksIncrementAfterMaxesWeekBasedOnCustomWorkout {
    NSArray *week2Workouts = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2];
    for (JFTOCustomWorkout *customWorkout in week2Workouts) {
        customWorkout.incrementAfterWeek = YES;
    }

    NSArray *expected = @[@2, @4];
    STAssertEqualObjects([[JFTOCustomPlan new] incrementMaxesWeeks], expected, @"");
}

- (void)testHasCorrectWeekNames {
    JFTOCustomPlan *plan = [JFTOCustomPlan new];
    STAssertEqualObjects([plan weekNames][0], @"5/5/5", @"");
    STAssertEqualObjects([plan weekNames][3], @"Deload", @"");
}

@end