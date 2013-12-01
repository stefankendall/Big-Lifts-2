#import "FTOTriumvirateViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOTriumvirateViewController.h"
#import "JFTOTriumvirateStore.h"
#import "JWorkout.h"
#import "JFTOTriumvirate.h"

@implementation FTOTriumvirateViewControllerTests

- (void)testReturnsNumberOfSectionsForEachLift {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    STAssertEquals([controller numberOfSectionsInTableView:controller.tableView], 4, @"");
}

- (void)testReturnsARowForEachLiftInWorkout {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    STAssertEquals([controller tableView:controller.tableView numberOfRowsInSection:0], 2, @"");
}

- (void)testReturnsUniqueSetsInWorkout {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] first];
    NSArray *sets = [controller uniqueSetsFor:triumvirate.workout];
    STAssertEquals( [sets count], 2U, @"");
}

- (void)testSetsSectionTitles {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    STAssertEqualObjects([controller tableView:controller.tableView titleForHeaderInSection:0], @"Bench", @"");
    STAssertEqualObjects([controller tableView:controller.tableView titleForHeaderInSection:1], @"Squat", @"");
}

@end