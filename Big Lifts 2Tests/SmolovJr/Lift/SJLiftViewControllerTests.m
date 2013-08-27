#import "SJLiftViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SJLiftViewController.h"

@implementation SJLiftViewControllerTests

- (void)testReturnsSectionCount {
    SJLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"sjLiftViewController"];
    STAssertEquals([controller numberOfSectionsInTableView:controller.tableView], 3, @"");
}

- (void)testReturnsRowCount {
    SJLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"sjLiftViewController"];
    STAssertEquals([controller tableView:controller.tableView numberOfRowsInSection:0], 4, @"");
}

@end