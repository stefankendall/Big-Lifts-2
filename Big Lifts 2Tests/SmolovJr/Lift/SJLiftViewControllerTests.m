#import "SJLiftViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SJLiftViewController.h"

@implementation SJLiftViewControllerTests

- (void)testReturnsSectionCount {
    SJLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"sjLiftViewController"];
    STAssertEquals((int)[controller numberOfSectionsInTableView:controller.tableView], 3, @"");
}

- (void)testReturnsRowCount {
    SJLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"sjLiftViewController"];
    STAssertEquals((int)[controller tableView:controller.tableView numberOfRowsInSection:0], 4, @"");
}

@end