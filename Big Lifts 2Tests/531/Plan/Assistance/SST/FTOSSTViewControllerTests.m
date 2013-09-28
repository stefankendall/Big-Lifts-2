#import "FTOSSTViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOSSTViewController.h"
#import "FTOSSTEditLiftCell.h"

@implementation FTOSSTViewControllerTests

- (void)testCreatesSstCells {
    FTOSSTViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoSst"];
    FTOSSTEditLiftCell *cell = (FTOSSTEditLiftCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertNotNil(cell, @"");
}

@end