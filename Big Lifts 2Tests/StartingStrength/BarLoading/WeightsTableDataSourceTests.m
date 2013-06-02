#import "WeightsTableDataSourceTests.h"
#import "BLStoreManager.h"
#import "WeightsTableDataSource.h"

@implementation WeightsTableDataSourceTests
@synthesize dataSource;

- (void)setUp {
    [[BLStoreManager instance] resetAllStores];
    dataSource = [WeightsTableDataSource new];
}

- (void)testReturnsPlateCount {
    STAssertFalse([dataSource tableView:nil numberOfRowsInSection:0] == 0, @"");
}

@end