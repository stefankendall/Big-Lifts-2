#import "FTOLiftsIncrementingViewControllerTests.h"
#import "FTOLiftsIncrementingViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"

@implementation FTOLiftsIncrementingViewControllerTests

- (void)testHasRowsForEachLift {
    FTOLiftsIncrementingViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLiftsIncrementing"];
    STAssertEquals((int) [controller tableView:controller.tableView numberOfRowsInSection:0], 4, @"");
}

@end