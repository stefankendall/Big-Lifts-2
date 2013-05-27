#import "SSLogDataSourceTests.h"
#import "SSLogDataSource.h"
#import "WorkoutLogCell.h"
#import "BLStoreManager.h"
#import "WorkoutLogStore.h"

@implementation SSLogDataSourceTests

- (void)setUp {
    [[BLStoreManager instance] resetAllStores];
    dataSource = [SSLogDataSource new];
}

- (void)testReturnsWorkoutLogCell {
    [[WorkoutLogStore instance] create];
    WorkoutLogCell *cell = (WorkoutLogCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertNotNil([cell setTable], @"");
}

- (void)testReturnsCorrectNumberOfRows {
    [[WorkoutLogStore instance] create];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 1, @"");
}

@end