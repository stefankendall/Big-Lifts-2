#import "FTOCustomWorkoutViewControllerTests.h"
#import "FTOCustomWorkoutViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomWorkout.h"
#import "FTOCustomWorkoutStore.h"
#import "Workout.h"

@implementation FTOCustomWorkoutViewControllerTests

- (void)testReturnsRowCountForWorkouts {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[FTOCustomWorkoutStore instance] first];
    STAssertEquals([controller tableView:controller.tableView numberOfRowsInSection:0], 6, @"");
}

- (void) testSetsTitleForWeek {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [controller viewWillAppear:YES];
    STAssertEqualObjects(controller.navigationItem.title, @"Week 2", @"");
}

- (void) testAddsSets {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    controller.customWorkout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [controller addSet: nil];
    STAssertEquals([controller.customWorkout.workout.sets count], 7U, @"");
}

@end