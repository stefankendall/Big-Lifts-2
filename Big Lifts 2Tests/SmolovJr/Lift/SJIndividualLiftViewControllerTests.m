#import "SJIndividualLiftViewControllerTests.h"
#import "SJIndividualLiftViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "SJSetCellWithPlates.h"
#import "JSJWorkoutStore.h"

@implementation SJIndividualLiftViewControllerTests

- (void)testLogsSetsWhenDoneButtonTapped {
    SJIndividualLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"sjIndividualLift"];
    controller.sjWorkout = [[JSJWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    [controller doneButtonTapped:nil];

    NSArray *smolovLogs = [[JWorkoutLogStore instance] findAllWhere:@"name" value:@"Smolov Jr"];
    STAssertEquals((int) [smolovLogs count], 1, @"");
    JWorkoutLog *workoutLog = smolovLogs[0];
    STAssertEquals((int) [workoutLog.sets count], 6, @"");
}

- (void)testShowsPlates {
    [[IAPAdapter instance] addPurchase:IAP_BAR_LOADING];
    SJIndividualLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"sjIndividualLift"];
    controller.sjWorkout = [[JSJWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    UITableViewCell *cell = [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0,1)];
    STAssertTrue([cell isKindOfClass:SJSetCellWithPlates.class], @"");
}

@end