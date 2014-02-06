#import "WorkoutLogTableDataSourceTests.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "WorkoutLogTableDataSource.h"
#import "BLStoreManager.h"
#import "JSetLog.h"
#import "JSetLogStore.h"

@implementation WorkoutLogTableDataSourceTests

- (void)testReturnsNumberOfSetsInWorkoutLog {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    JSetLog *set1 = [[JSetLogStore instance] create];
    set1.name = @"Squat";
    [workoutLog addSet:set1];

    JSetLog *set2 = [[JSetLogStore instance] create];
    set2.name = @"Press";
    [workoutLog addSet:set2];

    WorkoutLogTableDataSource *dataSource = [[WorkoutLogTableDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals((int)[dataSource tableView:nil numberOfRowsInSection:0], 2, @"");
}

- (void)testDoesNotCombinesIdenticalSets {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    JSetLog *set1 = [[JSetLogStore instance] create];
    set1.name = @"Squat";
    [workoutLog addSet:set1];

    JSetLog *set2 = [[JSetLogStore instance] create];
    set2.name = @"Squat";
    [workoutLog addSet:set2];

    WorkoutLogTableDataSource *dataSource = [[WorkoutLogTableDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals((int)[dataSource tableView:nil numberOfRowsInSection:0], 2, @"");
}

@end