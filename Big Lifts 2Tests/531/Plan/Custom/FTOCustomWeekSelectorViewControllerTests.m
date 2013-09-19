#import "FTOCustomWeekSelectorViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomWeekSelectorViewController.h"
#import "FTOCustomWorkoutStore.h"

@implementation FTOCustomWeekSelectorViewControllerTests

- (void)testSetsUpRowsForEachWeek {
    FTOCustomWeekSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWeekSelector"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 4, @"");

    UITableViewCell *cell = [controller tableView:controller.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([[cell textLabel] text], @"5/5/5", @"");
}

- (void)testCanDeleteWeeks {
    FTOCustomWeekSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWeekSelector"];
    [controller tableView:controller.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:0]];

    STAssertEquals([[FTOCustomWorkoutStore instance] count], 3, @"");
}

@end