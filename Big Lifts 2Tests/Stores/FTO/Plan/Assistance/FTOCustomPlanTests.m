#import "FTOCustomPlanTests.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkout.h"
#import "FTOCustomPlan.h"

@implementation FTOCustomPlanTests

- (void)testMarksIncrementAfterMaxesWeekBasedOnCustomWorkout {
    NSArray *week3Workouts = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@3];
    for (FTOCustomWorkout *customWorkout in week3Workouts) {
        customWorkout.incrementAfterWeek = YES;
    }

    NSArray *expected = @[@3, @4];
    STAssertEqualObjects([[FTOCustomPlan new] incrementMaxesWeeks], expected, @"");
}

@end