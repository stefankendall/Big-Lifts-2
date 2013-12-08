#import "FTOBoringButBigEditViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOBoringButBigEditViewController.h"
#import "FTOBoringButBigEditCell.h"
#import "PaddingTextField.h"
#import "PaddingRowTextField.h"

@implementation FTOBoringButBigEditViewControllerTests

- (void)testSetsUpCellsWithLiftData {
    FTOBoringButBigEditViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoBoringEdit"];
    FTOBoringButBigEditCell *cell = (FTOBoringButBigEditCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 0)];
    STAssertEqualObjects([[cell forLift] text], @"Bench", @"");
    STAssertEqualObjects([[cell useLift] text], @"Bench", @"");
}

@end