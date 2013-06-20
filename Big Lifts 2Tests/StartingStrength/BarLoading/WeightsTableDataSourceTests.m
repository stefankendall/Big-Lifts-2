#import "WeightsTableDataSourceTests.h"
#import "BLStoreManager.h"
#import "BarLoadingDataSource.h"
#import "WeightTableCell.h"
#import "BarWeightCell.h"
#import "StepperWithCell.h"
#import "PlateStore.h"
#import "Plate.h"
#import "TextFieldWithCell.h"
#import "RowUIButton.h"

@implementation WeightsTableDataSourceTests
@synthesize dataSource;

- (void)setUp {
    [super setUp];
    dataSource = [BarLoadingDataSource new];
}

- (void)testReturnsPlateCount {
    STAssertTrue([dataSource tableView:nil numberOfRowsInSection:1] > 0, @"");
}

- (void)testAddsOneRowForAddingPlates {
    UITableViewCell *addCell = [dataSource tableView:nil cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:[[PlateStore instance] count] inSection:1]];
    NSString *addText = [[addCell textLabel] text];
    STAssertTrue([addText rangeOfString:@"Add"].location != NSNotFound, @"");
}

- (void)testWiresCellsWithData {
    WeightTableCell *cell = (WeightTableCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    STAssertTrue([[[cell weightLabel] text] isEqualToString:@"45.0"], @"");
    STAssertTrue([[[cell unitsLabel] text] isEqualToString:@"lbs"], @"");
}

- (void)testPlateCountChangeAdjustsPlateCount {
    WeightTableCell *cell = (WeightTableCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [cell.stepper setValue:1];
    [dataSource plateCountChanged:cell.stepper];
    Plate *p = [[PlateStore instance] atIndex:0];
    STAssertEquals([p.count intValue], 7, @"");
}

- (void)testPlateCountDoesNotGoNegative {
    WeightTableCell *cell = (WeightTableCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [cell.stepper setValue:-2];
    Plate *p = [[PlateStore instance] atIndex:0];
    p.count = [NSNumber numberWithInt:1];
    [dataSource plateCountChanged:cell.stepper];
    STAssertEquals([p.count intValue], 0, @"");
}

- (void)testPlateStepperMinimumReadjustedWhenPlatesAdded {
    WeightTableCell *cell = (WeightTableCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [cell.stepper setValue:-2];
    Plate *p = [[PlateStore instance] atIndex:0];
    p.count = [NSNumber numberWithInt:1];

    [dataSource plateCountChanged:cell.stepper];
    STAssertEquals([cell.stepper minimumValue], 0.0, @"");

    [cell.stepper setValue:1];
    [dataSource plateCountChanged:cell.stepper];
    STAssertEquals([cell.stepper minimumValue], -2.0, @"");
}

- (void)testBarWeightCellIsSetOnLoad {
    BarWeightCell *cell = (BarWeightCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *barText = [[cell textField] text];

    STAssertFalse([barText isEqualToString:@""], @"");
}

- (void)testModifyCellForPlateCountHandles0 {
    WeightTableCell *cell = (WeightTableCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [dataSource modifyCellForPlateCount:cell currentPlateCount:0];
    STAssertTrue([[cell platesLabel] isHidden], @"");
    STAssertTrue([[cell countLabel] isHidden], @"");
    STAssertFalse([[cell deleteButton] isHidden], @"");

    [dataSource modifyCellForPlateCount:cell currentPlateCount:2];

    STAssertFalse([[cell platesLabel] isHidden], @"");
    STAssertFalse([[cell countLabel] isHidden], @"");
    STAssertTrue([[cell deleteButton] isHidden], @"");
}

- (void)testTappingDeleteDeletesPlate {
    RowUIButton *button = [RowUIButton new];
    button.indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    int oldCount = [[PlateStore instance] count];
    [dataSource deleteButtonTapped:button];
    STAssertEquals( [[PlateStore instance] count], oldCount - 1, @"");

}

@end