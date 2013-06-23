#import "SSLiftViewControllerTests.h"
#import "SSLiftViewController.h"
#import "SSLiftSummaryDataSource.h"
#import "SSWorkoutStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSStateStore.h"
#import "SSState.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"

@implementation SSLiftViewControllerTests

- (void)testSelectingANewWorkoutChangesDataSourceWorkout {
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    [controller switchWorkoutToIndex:1];
    SSWorkout *workoutB = [[SSWorkoutStore instance] atIndex:1];
    STAssertEquals(workoutB, [controller.ssLiftSummaryDataSource ssWorkout], @"");
    STAssertEquals(workoutB, controller.ssWorkout, @"");
}

- (void)testSetsAppropriateWorkoutBasedOnLastWorkout {
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    SSState *state = [[SSStateStore instance] first];
    state.lastWorkout = [[SSWorkoutStore instance] first];

    [controller viewWillAppear:YES];

    STAssertEqualObjects(controller.ssWorkout, [[SSWorkoutStore instance] last], @"");
}

- (void)testSwitchToWorkoutIndexHonorsAlternation {
    [[SSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    [controller switchWorkoutToIndex:1];
    STAssertEqualObjects(controller.ssWorkout.name, @"B", @"");
}

- (void)testSwitchToWorkoutOnusAWeeks {
    [[SSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    SSState *state = [[SSStateStore instance] first];
    state.workoutAAlternation = @1;
    [controller switchWorkoutToIndex:0];
    STAssertEqualObjects(controller.ssWorkout.name, @"A", @"");
    Workout *lastWorkout = controller.ssWorkout.workouts[2];
    Set *set = lastWorkout.sets[0];
    STAssertEqualObjects(set.lift.name, @"Power Clean", @"");
}

@end