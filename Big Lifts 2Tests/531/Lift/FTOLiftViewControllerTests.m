#import "FTOLiftViewControllerTests.h"
#import "FTOLiftViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"

@implementation FTOLiftViewControllerTests

- (void)testHasRowsForEachWeek {
    FTOLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLift"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 4, @"");
    STAssertEquals([controller numberOfSectionsInTableView:nil], 4, @"");
}

@end