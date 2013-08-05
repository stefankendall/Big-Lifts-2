#import "FTOChangeLiftsViewControllerTests.h"
#import "FTOChangeLiftsViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOChangeLiftCell.h"
#import "RowTextField.h"
#import "FTOLiftStore.h"

@implementation FTOChangeLiftsViewControllerTests

-(void) testHasRowsForAllLifts {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 4, @"");
}

-(void) testCanChangeLiftNames {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    FTOChangeLiftCell * cell = (FTOChangeLiftCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textField setText:@"Power Clean"];
    [controller textFieldDidEndEditing:(id) cell.textField];
    STAssertEqualObjects([[[FTOLiftStore instance] first] name], @"Power Clean", @"");
}

@end