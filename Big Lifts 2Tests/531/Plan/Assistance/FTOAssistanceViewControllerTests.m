#import "FTOAssistanceViewControllerTests.h"
#import "FTOAssistanceViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JFTOAssistanceStore.h"
#import "FTOAssistance.h"
#import "Purchaser.h"
#import "IAPAdapter.h"
#import "JFTOAssistance.h"

@implementation FTOAssistanceViewControllerTests

- (void)testChecksSelectedAssistanceNone {
    FTOAssistanceViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAssistance"];
    UITableViewCell *cell = [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEquals([cell accessoryType], UITableViewCellAccessoryCheckmark, @"");
}

- (void)testChecksSelectedAssistanceBbb {
    [[[JFTOAssistanceStore instance] first] setName:FTO_ASSISTANCE_BORING_BUT_BIG];
    FTOAssistanceViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAssistance"];
    UITableViewCell *cell = [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    STAssertEquals([cell accessoryType], UITableViewCellAccessoryCheckmark, @"");
}

- (void)testTappingRowChangesAssistance {
    FTOAssistance *assistance = [[JFTOAssistanceStore instance] first];
    [assistance setName:FTO_ASSISTANCE_BORING_BUT_BIG];
    FTOAssistanceViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAssistance"];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects(assistance.name, FTO_ASSISTANCE_NONE, @"");
}

- (void)testBlocksSegueForSstIfNotPurchased {
    FTOAssistanceViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAssistance"];
    STAssertFalse([controller shouldPerformSegueWithIdentifier:IAP_FTO_SST sender:nil], @"");
}

- (void)testAllowsSegueIfSstPurchased {
    [[IAPAdapter instance] addPurchase:IAP_FTO_SST];
    FTOAssistanceViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAssistance"];
    STAssertTrue([controller shouldPerformSegueWithIdentifier:IAP_FTO_SST sender:nil], @"");
}

@end