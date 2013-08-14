#import "FTOTriumvirateViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOTriumvirateViewController.h"
#import "FTOTriumvirate.h"
#import "BLStore.h"
#import "FTOTriumvirateStore.h"
#import "Workout.h"
#import "Set.h"

@implementation FTOTriumvirateViewControllerTests

-(void) testReturnsNumberOfSectionsForEachLift {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    STAssertEquals([controller numberOfSectionsInTableView:controller.tableView], 4, @"");
}

-(void) testReturnsARowForEachLiftInWorkout {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    STAssertEquals([controller tableView:controller.tableView numberOfRowsInSection:0], 2, @"");
}

- (void) testReturnsUniqueSetsInWorkout {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] first];
    NSArray *sets = [controller uniqueSetsFor:triumvirate.workout];
    STAssertEquals( [sets count], 2U, @"");
}

- (void) testCountsSetsInWorkout {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] first];
    Set *set = triumvirate.workout.sets[0];
    int count = [controller countSetsInWorkout:triumvirate.workout forSet:set];
    STAssertEquals(count, 5, @"");
}

- (void) testSetsSectionTitles {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    STAssertEqualObjects([controller tableView:controller.tableView titleForHeaderInSection:0], @"Bench", @"");
    STAssertEqualObjects([controller tableView:controller.tableView titleForHeaderInSection:1], @"Squat", @"");
}

@end