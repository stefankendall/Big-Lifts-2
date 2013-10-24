#import "SSLiftViewControllerTests.h"
#import "SSLiftViewController.h"
#import "SSWorkoutStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSStateStore.h"
#import "SSState.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"
#import "SSLiftSummaryCell.h"

@implementation SSLiftViewControllerTests

- (void)testReturnsCorrectNumberOfRows {
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    STAssertEquals(1, [controller tableView:nil numberOfRowsInSection:0], @"");
    STAssertEquals(3, [controller tableView:nil numberOfRowsInSection:1], @"");
}

- (void)testReturnsLiftSummaryCells {
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    UITableViewCell *cell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    STAssertTrue([cell isKindOfClass:SSLiftSummaryCell.class], @"");
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
    controller.aWorkout = NO;
    [controller switchWorkout];
    STAssertEqualObjects(controller.ssWorkout.name, @"B", @"");
}

- (void)testSwitchToWorkoutOnusAWeeks {
    [[SSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    SSState *state = [[SSStateStore instance] first];
    state.workoutAAlternation = @1;
    controller.aWorkout = YES;
    [controller switchWorkout];
    STAssertEqualObjects(controller.ssWorkout.name, @"A", @"");
    Workout *lastWorkout = controller.ssWorkout.workouts[2];
    Set *set = lastWorkout.orderedSets[0];
    STAssertEqualObjects(set.lift.name, @"Power Clean", @"");
}

@end