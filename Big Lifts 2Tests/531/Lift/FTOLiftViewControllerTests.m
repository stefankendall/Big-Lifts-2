#import "FTOLiftViewControllerTests.h"
#import "FTOLiftViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"

@implementation FTOLiftViewControllerTests

- (void)testHasRowsForEachWeek {
    FTOLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLift"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 4, @"");
    STAssertEquals([controller numberOfSectionsInTableView:nil], 4, @"");
}

- (void) testHasLiftNamesInCells {
    FTOLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLift"];
    UITableViewCell *cell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([[cell textLabel] text], @"Bench", @"");
}

@end