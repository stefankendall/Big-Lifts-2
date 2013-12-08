#import "FTOBoringButBigEditViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOBoringButBigEditViewController.h"
#import "FTOBoringButBigEditCell.h"
#import "PaddingTextField.h"
#import "PaddingRowTextField.h"
#import "JFTOBoringButBigLift.h"
#import "JFTOBoringButBigLiftStore.h"
#import "JLift.h"
#import "JFTOLift.h"

@implementation FTOBoringButBigEditViewControllerTests

- (void)testSetsUpCellsWithLiftData {
    FTOBoringButBigEditViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoBoringEdit"];
    FTOBoringButBigEditCell *cell = (FTOBoringButBigEditCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 0)];
    STAssertEqualObjects([[cell forLift] text], @"Bench", @"");
    STAssertEqualObjects([[cell useLift] text], @"Bench", @"");
}

- (void)testCanChangeBbbLifts {
    FTOBoringButBigEditViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoBoringEdit"];
    FTOBoringButBigEditCell *cell = (FTOBoringButBigEditCell *)
            [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 0)];

    [cell.liftPicker selectRow:1 inComponent:0 animated:NO];
    [controller textFieldDidEndEditing:cell.useLift];

    JFTOBoringButBigLift *bbbLift = [[JFTOBoringButBigLiftStore instance] atIndex:0];
    STAssertEqualObjects(bbbLift.boringLift.name, @"Squat", @"");

    cell = (FTOBoringButBigEditCell *)
            [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 0)];
    STAssertEqualObjects([cell.useLift text], @"Squat", @"");
}
@end