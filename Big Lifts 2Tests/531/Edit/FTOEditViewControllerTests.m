#import "FTOEditViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOEditViewController.h"

@implementation FTOEditViewControllerTests

- (void)testHasCorrectRows {
    FTOEditViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoEdit"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 4, @"");
}

@end