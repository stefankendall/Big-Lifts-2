#import "FTOFullCustomWeekViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOFullCustomWeekViewController.h"

@implementation FTOFullCustomWeekViewControllerTests

- (void)testHasSections {
    FTOFullCustomWeekViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoFullCustomWeek"];
    STAssertEquals((int) [controller numberOfSectionsInTableView:controller.tableView], 4, @"");
    STAssertEqualObjects([controller tableView:controller.tableView titleForHeaderInSection:0], @"5/5/5", @"");
}

- (void)testHasRowForEachLift {
    FTOFullCustomWeekViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoFullCustomWeek"];
    STAssertEquals((int) [controller tableView:controller.tableView numberOfRowsInSection:0], 4, @"");
}

@end