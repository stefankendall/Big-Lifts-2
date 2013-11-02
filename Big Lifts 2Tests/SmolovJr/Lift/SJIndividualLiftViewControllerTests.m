#import "SJIndividualLiftViewControllerTests.h"
#import "SJIndividualLiftViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SJWorkoutStore.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "SJSetCellWithPlates.h"

@implementation SJIndividualLiftViewControllerTests

- (void)testLogsSetsWhenDoneButtonTapped {
    SJIndividualLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"sjIndividualLift"];
    controller.sjWorkout = [[SJWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    [controller doneButtonTapped:nil];

    NSArray *smolovLogs = [[WorkoutLogStore instance] findAllWhere:@"name" value:@"Smolov Jr"];
    STAssertEquals([smolovLogs count], 1U, @"");
    WorkoutLog *workoutLog = smolovLogs[0];
    STAssertEquals([workoutLog.orderedSets count], 6U, @"");
}

- (void)testShowsPlates {
    [[IAPAdapter instance] addPurchase:IAP_BAR_LOADING];
    SJIndividualLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"sjIndividualLift"];
    controller.sjWorkout = [[SJWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    UITableViewCell *cell = [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertTrue([cell isKindOfClass:SJSetCellWithPlates.class], @"");
}

@end