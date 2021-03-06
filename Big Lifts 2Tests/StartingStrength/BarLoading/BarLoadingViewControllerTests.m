#import "BarLoadingViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "BarLoadingViewController.h"
#import "IAPAdapter.h"
#import "PurchaseOverlay.h"
#import "WeightTableCell.h"
#import "StepperWithCell.h"
#import "RowUIButton.h"
#import "TextFieldWithCell.h"
#import "JBarStore.h"
#import "JBar.h"
#import "JPlateStore.h"
#import "JPlate.h"

@implementation BarLoadingViewControllerTests

- (void)testAddsDisableViewIfUnpurchased {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    STAssertNotNil([controller.view viewWithTag:kPurchaseOverlayTag], @"");
}

- (void)testNoDisableViewIfPurchased {
    [[IAPAdapter instance] addPurchase:@"barLoading"];
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    STAssertNil([controller.view viewWithTag:kPurchaseOverlayTag], @"");
}

- (void)testDisableViewIsRemovedAfterPurchase {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    [[IAPAdapter instance] addPurchase:@"barLoading"];
    [controller viewWillAppear:YES];
    STAssertNil([controller.view viewWithTag:kPurchaseOverlayTag], @"");
}

- (void)testReturnsPlateCount {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    STAssertTrue([controller tableView:controller.tableView numberOfRowsInSection:1] > 0, @"");
}

- (void)testAddsOneRowForAddingPlates {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    UITableViewCell *addCell = [controller tableView:controller.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:[[JPlateStore instance] count] inSection:1]];
    NSString *addText = [[addCell textLabel] text];
    STAssertTrue([addText rangeOfString:@"Add"].location != NSNotFound, @"");
}

- (void)testWiresCellsWithData {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    WeightTableCell *cell = (WeightTableCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    STAssertEqualObjects([[cell weightLabel] text], @"45", @"");
    STAssertTrue([[cell unitsLabel] text], @"lbs", @"");
}

- (void)testPlateCountChangeAdjustsPlateCount {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    WeightTableCell *cell = (WeightTableCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [cell.stepper setValue:1];
    [controller plateCountChanged:cell.stepper];
    JPlate *p = [[JPlateStore instance] atIndex:0];
    STAssertEquals([p.count intValue], 7, @"");
}

- (void)testPlateCountDoesNotGoNegative {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    WeightTableCell *cell = (WeightTableCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [cell.stepper setValue:-2];
    JPlate *p = [[JPlateStore instance] atIndex:0];
    p.count = [NSNumber numberWithInt:1];
    [controller plateCountChanged:cell.stepper];
    STAssertEquals([p.count intValue], 0, @"");
}

- (void)testPlateStepperMinimumReadjustedWhenPlatesAdded {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    WeightTableCell *cell = (WeightTableCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [cell.stepper setValue:-2];
    JPlate *p = [[JPlateStore instance] atIndex:0];
    p.count = [NSNumber numberWithInt:1];

    [controller plateCountChanged:cell.stepper];
    STAssertEquals([cell.stepper minimumValue], 0.0, @"");

    [cell.stepper setValue:1];
    [controller plateCountChanged:cell.stepper];
    STAssertEquals([cell.stepper minimumValue], -2.0, @"");
}

- (void)testModifyCellForPlateCountHandles0 {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    WeightTableCell *cell = (WeightTableCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [controller modifyCellForPlateCount:cell currentPlateCount:0];
    STAssertTrue([[cell platesLabel] isHidden], @"");
    STAssertTrue([[cell countLabel] isHidden], @"");
    STAssertFalse([[cell deleteButton] isHidden], @"");

    [controller modifyCellForPlateCount:cell currentPlateCount:2];

    STAssertFalse([[cell platesLabel] isHidden], @"");
    STAssertFalse([[cell countLabel] isHidden], @"");
    STAssertTrue([[cell deleteButton] isHidden], @"");
}

- (void)testTappingDeleteDeletesPlate {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    RowUIButton *button = [RowUIButton new];
    button.indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    int oldCount = [[JPlateStore instance] count];
    [controller deleteButtonTapped:button];
    STAssertEquals( [[JPlateStore instance] count], oldCount - 1, @"");
}

- (void) testShowsFractionalPlates {
    JPlate *fractionalPlate = [[JPlateStore instance] create];
    fractionalPlate.weight = N(1.25);
    fractionalPlate.count = @2;
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    WeightTableCell *cell = (WeightTableCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:1]];
    STAssertEqualObjects([[cell weightLabel] text], @"1.25", @"");
}

@end