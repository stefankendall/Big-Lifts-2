#import "WorkoutLogCellTests.h"
#import "WorkoutLogCell.h"
#import "BLStoreManager.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"

@implementation WorkoutLogCellTests

- (void)setUp {
    [[BLStoreManager instance] resetAllStores];
}

- (void)testSetWorkoutSetsTableDataSource {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    WorkoutLogCell *cell = [WorkoutLogCell create];

    [cell setWorkoutLog:workoutLog];
    STAssertNotNil([[cell setTable] dataSource], @"");
}

- (void)testSetWorkoutFormatsDate {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    workoutLog.date = [NSDate date];
    WorkoutLogCell *cell = [WorkoutLogCell create];

    [cell setWorkoutLog:workoutLog];
    STAssertEqualObjects([[cell dateLabel] text], @"06/11", @"");

}

@end