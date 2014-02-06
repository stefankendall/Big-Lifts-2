#import "SVLiftSelectorViewControllerTests.h"
#import "SVLiftSelectorViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"

@implementation SVLiftSelectorViewControllerTests

- (void)testHasCellsForEachWorkout {
    SVLiftSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"svLiftSelector"];
    STAssertEquals((int)[controller tableView:controller.tableView numberOfRowsInSection:0], 9, @"");
    STAssertEquals((int)[controller tableView:controller.tableView numberOfRowsInSection:1], 13, @"");
    STAssertEquals((int)[controller tableView:controller.tableView numberOfRowsInSection:2], 6, @"");
    STAssertEquals((int)[controller tableView:controller.tableView numberOfRowsInSection:3], 12, @"");
    STAssertEquals((int)[controller tableView:controller.tableView numberOfRowsInSection:4], 2, @"");
}

@end