#import "JLift.h"
#import "JSSWorkout.h"
#import "SSLiftViewControllerTests.h"
#import "SSLiftViewController.h"
#import "JSSWorkoutStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JSSStateStore.h"
#import "SSLiftSummaryCell.h"
#import "JSSState.h"
#import "JSet.h"
#import "JWorkout.h"

@implementation SSLiftViewControllerTests

- (void)testReturnsCorrectNumberOfRows {
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    STAssertEquals(1, (int)[controller tableView:nil numberOfRowsInSection:0], @"");
    STAssertEquals(3, (int)[controller tableView:nil numberOfRowsInSection:1], @"");
}

- (void)testReturnsLiftSummaryCells {
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    UITableViewCell *cell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    STAssertTrue([cell isKindOfClass:SSLiftSummaryCell.class], @"");
}

- (void)testSetsAppropriateWorkoutBasedOnLastWorkout {
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    JSSState *state = [[JSSStateStore instance] first];
    state.lastWorkout = [[JSSWorkoutStore instance] first];

    [controller viewWillAppear:YES];

    STAssertEqualObjects(controller.ssWorkout, [[JSSWorkoutStore instance] last], @"");
}

- (void)testSwitchToWorkoutIndexHonorsAlternation {
    [[JSSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    controller.aWorkout = NO;
    [controller switchWorkout];
    STAssertEqualObjects(controller.ssWorkout.name, @"B", @"");
}

- (void)testSwitchToWorkoutOnusAWeeks {
    [[JSSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    SSLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ssWorkoutSummaryViewController"];
    JSSState *state = [[JSSStateStore instance] first];
    state.workoutAAlternation = @1;
    controller.aWorkout = YES;
    [controller switchWorkout];
    STAssertEqualObjects(controller.ssWorkout.name, @"A", @"");
    JWorkout *lastWorkout = controller.ssWorkout.workouts[2];
    JSet *set = lastWorkout.sets[0];
    STAssertEqualObjects(set.lift.name, @"Power Clean", @"");
}

@end