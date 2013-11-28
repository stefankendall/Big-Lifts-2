#import "JFTOCustomPlanTests.h"
#import "JFTOCustomWorkout.h"
#import "JFTOCustomWorkoutStore.h"
#import "JFTOCustomPlan.h"

@implementation JFTOCustomPlanTests

- (void)testMarksIncrementAfterMaxesWeekBasedOnCustomWorkout {
    NSArray *week3Workouts = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@3];
    for (JFTOCustomWorkout *customWorkout in week3Workouts) {
        customWorkout.incrementAfterWeek = YES;
    }

    NSArray *expected = @[@3, @4];
    STAssertEqualObjects([[JFTOCustomPlan new] incrementMaxesWeeks], expected, @"");
}

@end