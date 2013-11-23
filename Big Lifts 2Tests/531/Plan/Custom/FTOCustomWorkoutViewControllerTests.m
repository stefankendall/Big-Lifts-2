#import "FTOCustomWorkoutViewControllerTests.h"
#import "FTOCustomWorkoutViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomWorkout.h"
#import "FTOCustomWorkoutStore.h"
#import "Workout.h"
#import "FTOCustomWorkoutToolbar.h"

@implementation FTOCustomWorkoutViewControllerTests

- (void)testReturnsRowCountForWorkouts {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[FTOCustomWorkoutStore instance] first];
    STAssertEquals([controller tableView:controller.tableView numberOfRowsInSection:1], 6, @"");
}

- (void)testSetsTitleForWeek {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [controller viewWillAppear:YES];
    STAssertEqualObjects(controller.navigationItem.title, @"Week 2", @"");
}

- (void)testAddsSets {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [controller addSet];
    STAssertEquals([controller.customWorkout.workout.orderedSets count], 7U, @"");
}

- (void)testCanDeleteSets {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [controller tableView:controller.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:NSIP(0, 1)];
    STAssertEquals([controller.customWorkout.workout.orderedSets count], 5U, @"");
}

- (void)testSetsIncrementSwitch {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    FTOCustomWorkoutToolbar *toolbar = (FTOCustomWorkoutToolbar *) [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 0)];
    STAssertFalse([toolbar.incrementAfterWeekSwitch isOn], @"");

    controller.customWorkout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@4][0];
    toolbar = (FTOCustomWorkoutToolbar *) [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 0)];
    STAssertTrue([toolbar.incrementAfterWeekSwitch isOn], @"");
}

@end