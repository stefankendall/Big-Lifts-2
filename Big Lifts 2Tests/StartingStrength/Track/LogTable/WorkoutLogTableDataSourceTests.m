#import "WorkoutLogTableDataSourceTests.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "WorkoutLogTableDataSource.h"
#import "BLStoreManager.h"
#import "SetLog.h"
#import "SetLogStore.h"

@implementation WorkoutLogTableDataSourceTests

- (void)testReturnsNumberOfSetsInWorkoutLog {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    SetLog *set1 = [[SetLogStore instance] create];
    set1.name = @"Squat";
    [workoutLog.sets addObject:set1];

    SetLog *set2 = [[SetLogStore instance] create];
    set2.name = @"Press";
    [workoutLog.sets addObject:set2];

    WorkoutLogTableDataSource *dataSource = [[WorkoutLogTableDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 2, @"");
}

- (void)testCombinesIdenticalSets {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    SetLog *set1 = [[SetLogStore instance] create];
    set1.name = @"Squat";
    [workoutLog.sets addObject:set1];

    SetLog *set2 = [[SetLogStore instance] create];
    set2.name = @"Squat";
    [workoutLog.sets addObject:set2];

    WorkoutLogTableDataSource *dataSource = [[WorkoutLogTableDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 1, @"");
}

@end