#import "JWorkout.h"
#import "JFTOCustomWorkout.h"
#import "FTOCustomWorkoutViewControllerTests.h"
#import "FTOCustomWorkoutViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JFTOCustomWorkoutStore.h"
#import "FTOCustomWorkoutToolbar.h"

@implementation FTOCustomWorkoutViewControllerTests

- (void)testReturnsRowCountForWorkouts {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[JFTOCustomWorkoutStore instance] first];
    STAssertEquals((int) [controller tableView:controller.tableView numberOfRowsInSection:1], 6, @"");
}

- (void)testSetsTitleForWeek {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [controller viewWillAppear:YES];
    STAssertEqualObjects(controller.navigationItem.title, @"Week 2", @"");
}

- (void)testAddsSets {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [controller addSet];
    STAssertEquals((int) [controller.customWorkout.workout.orderedSets count], 7, @"");
}

- (void)testCanDeleteSets {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [controller tableView:controller.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:NSIP(0, 1)];
    STAssertEquals((int) [controller.customWorkout.workout.orderedSets count], 5, @"");
}

- (void)testSetsIncrementSwitch {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    FTOCustomWorkoutToolbar *toolbar = (FTOCustomWorkoutToolbar *) [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 0)];
    STAssertFalse([toolbar.incrementAfterWeekSwitch isOn], @"");

    controller.customWorkout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@4][0];
    toolbar = (FTOCustomWorkoutToolbar *) [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 0)];
    STAssertTrue([toolbar.incrementAfterWeekSwitch isOn], @"");
}

@end