#import "FTOCustomWorkoutViewControllerTests.h"
#import "FTOCustomWorkoutViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"

@implementation FTOCustomWorkoutViewControllerTests

- (void) testReturnsRowCountForWorkouts {
    FTOCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWorkoutViewController"];
    STAssertEquals([controller tableView: controller.tableView numberOfRowsInSection:0], 6, @"");
}

@end