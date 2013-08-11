#import "FTOAssistanceViewControllerTests.h"
#import "FTOAssistanceViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOAssistanceStore.h"
#import "FTOAssistance.h"

@implementation FTOAssistanceViewControllerTests

- (void)testChecksSelectedAssistanceNone {
    FTOAssistanceViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAssistance"];
    UITableViewCell *cell = [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEquals([cell accessoryType], UITableViewCellAccessoryCheckmark, @"");
}

- (void)testChecksSelectedAssistanceBbb {
    [[[FTOAssistanceStore instance] first] setName:FTO_ASSISTANCE_BORING_BUT_BIG];
    FTOAssistanceViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAssistance"];
    UITableViewCell *cell = [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    STAssertEquals([cell accessoryType], UITableViewCellAccessoryCheckmark, @"");
}

- (void)testTappingRowChangesAssistance {
    FTOAssistance *assistance = [[FTOAssistanceStore instance] first];
    [assistance setName:FTO_ASSISTANCE_BORING_BUT_BIG];
    FTOAssistanceViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAssistance"];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects(assistance.name, FTO_ASSISTANCE_NONE, @"");
}

@end