#import "FTOTriumvirateViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOTriumvirateViewController.h"
#import "JFTOTriumvirateStore.h"
#import "JWorkout.h"
#import "JFTOTriumvirate.h"

@implementation FTOTriumvirateViewControllerTests

- (void)testReturnsNumberOfSectionsForEachLift {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    STAssertEquals((int) [controller numberOfSectionsInTableView:controller.tableView], 4, @"");
}

- (void)testReturnsARowForEachLiftInWorkout {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    STAssertEquals((int) [controller tableView:controller.tableView numberOfRowsInSection:0], 2, @"");
}

- (void)testReturnsUniqueSetsInWorkout {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] first];
    NSArray *sets = [controller uniqueSetsFor:triumvirate.workout];
    STAssertEquals((int) [sets count], 2, @"");
}

- (void)testSetsSectionTitles {
    FTOTriumvirateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirate"];
    STAssertEqualObjects([controller tableView:controller.tableView titleForHeaderInSection:0], @"Bench", @"");
    STAssertEqualObjects([controller tableView:controller.tableView titleForHeaderInSection:1], @"Squat", @"");
}

@end