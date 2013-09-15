#import "FTOCustomWeekSelectorViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomWeekSelectorViewController.h"

@implementation FTOCustomWeekSelectorViewControllerTests

- (void)testSetsUpRowsForEachWeek {
    FTOCustomWeekSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWeekSelector"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 4, @"");

    UITableViewCell *cell = [controller tableView:controller.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([[cell textLabel] text], @"Week 1", @"");
}

@end