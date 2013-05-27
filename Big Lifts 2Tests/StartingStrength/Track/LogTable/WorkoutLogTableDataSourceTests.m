#import "WorkoutLogTableDataSourceTests.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "WorkoutLogTableDataSource.h"
#import "SetStore.h"

@implementation WorkoutLogTableDataSourceTests

- (void)testReturnsNumberOfSetsInWorkoutLog {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    [workoutLog.sets addObject:[[SetStore instance] create]];
    [workoutLog.sets addObject:[[SetStore instance] create]];

    WorkoutLogTableDataSource *dataSource = [[WorkoutLogTableDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 2, @"");
}

@end