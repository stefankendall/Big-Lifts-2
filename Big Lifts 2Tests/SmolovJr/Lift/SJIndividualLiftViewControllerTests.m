#import "SJIndividualLiftViewControllerTests.h"
#import "SJIndividualLiftViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SJWorkoutStore.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"

@implementation SJIndividualLiftViewControllerTests

-(void) testLogsSetsWhenDoneButtonTapped {
    SJIndividualLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"sjIndividualLift"];
    controller.sjWorkout = [[SJWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    [controller doneButtonTapped: nil];

    NSArray *smolovLogs = [[WorkoutLogStore instance] findAllWhere:@"name" value:@"Smolov Jr"];
    STAssertEquals([smolovLogs count], 1U, @"");
    WorkoutLog *workoutLog = smolovLogs[0];
    STAssertEquals([workoutLog.sets count], 6U, @"");
}

@end