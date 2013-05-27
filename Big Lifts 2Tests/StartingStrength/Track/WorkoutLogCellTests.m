#import "WorkoutLogCellTests.h"
#import "WorkoutLogCell.h"
#import "BLStoreManager.h"
#import "WorkoutLogStore.h"

@implementation WorkoutLogCellTests

- (void)setUp {
    [[BLStoreManager instance] resetAllStores];
}

- (void)testSetWorkoutSetsTableDataSource {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    WorkoutLogCell *cell = [WorkoutLogCell createNewTextCellFromNib];

    [cell setWorkoutLog:workoutLog];
    STAssertNotNil([[cell workoutLogTable] dataSource], @"");
}

@end