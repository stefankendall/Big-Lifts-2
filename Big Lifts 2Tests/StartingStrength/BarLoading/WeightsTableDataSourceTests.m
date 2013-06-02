#import "WeightsTableDataSourceTests.h"
#import "BLStoreManager.h"
#import "WeightsTableDataSource.h"
#import "WeightTableCell.h"

@implementation WeightsTableDataSourceTests
@synthesize dataSource;

- (void)setUp {
    [[BLStoreManager instance] resetAllStores];
    dataSource = [WeightsTableDataSource new];
}

- (void)testReturnsPlateCount {
    STAssertFalse([dataSource tableView:nil numberOfRowsInSection:0] == 0, @"");
}

- (void)testWiresCellsWithData {
    WeightTableCell *cell = (WeightTableCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertTrue([[[cell weightLabel] text] isEqualToString:@"45.0"], @"");
    STAssertTrue([[[cell unitsLabel] text] isEqualToString:@"lbs"], @"");
}

@end