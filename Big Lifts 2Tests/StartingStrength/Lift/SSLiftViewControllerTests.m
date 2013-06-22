#import "SSLiftViewControllerTests.h"
#import "SSLiftViewController.h"
#import "SSLiftSummaryDataSource.h"
#import "SSWorkoutStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSStateStore.h"
#import "SSState.h"

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
    SSState *state = [[SSStateStore instance] create];
    state.lastWorkout = [[SSWorkoutStore instance] first];

    [controller viewWillAppear:YES];

    STAssertEqualObjects(controller.ssWorkout, [[SSWorkoutStore instance] last], @"");
}

@end