#import "FTOCustomAssistanceLiftViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomAssistanceLiftViewController.h"
#import "JFTOCustomAssistanceLiftStore.h"

@implementation FTOCustomAssistanceLiftViewControllerTests

- (void)testReturnsNumberOfAssistanceLiftsForRows {
    FTOCustomAssistanceLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAsstLifts"];
    [[JFTOCustomAssistanceLiftStore instance] create];
    [[JFTOCustomAssistanceLiftStore instance] create];
    int rows = [controller tableView:controller.tableView numberOfRowsInSection:0];
    STAssertEquals(rows, 2, @"");
}

- (void)testCanDeleteLifts {
    [[JFTOCustomAssistanceLiftStore instance] create];
    FTOCustomAssistanceLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAsstLifts"];
    [controller tableView:controller.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:NSIP(0, 0)];
    STAssertEquals([[JFTOCustomAssistanceLiftStore instance] count], 0, @"");
}

@end