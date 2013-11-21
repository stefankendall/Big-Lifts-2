#import "FTOWorkoutLogAmrapDataSourceTests.h"
#import "FTOWorkoutLogAmrapDataSource.h"
#import "SetLogStore.h"
#import "WorkoutLogStore.h"
#import "SetLog.h"
#import "WorkoutLog.h"
#import "SetLogCell.h"
#import "LogMaxEstimateCell.h"

@implementation FTOWorkoutLogAmrapDataSourceTests

- (void)testReturnsHeaviestAmrapSet {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    SetLog *warmup = [[SetLogStore instance] createWithName:@"Squat" weight:N(100) reps:1 warmup:YES assistance:NO amrap:NO order:0];
    SetLog *work1 = [[SetLogStore instance] createWithName:@"Squat" weight:N(180) reps:2 warmup:NO assistance:NO amrap:YES order:1];
    SetLog *work2 = [[SetLogStore instance] createWithName:@"Squat" weight:N(175) reps:1 warmup:NO assistance:NO amrap:YES order:2];
    [workoutLog.sets addObjectsFromArray:@[warmup, work1, work2]];

    FTOWorkoutLogAmrapDataSource *dataSource = [[FTOWorkoutLogAmrapDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:SETS_SECTION], 1, @"");
    SetLogCell *cell = (SetLogCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([cell.weightLabel text], @"180 lbs", @"");
}

- (void)testReturnsLastSetIfNoAmrap {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    SetLog *warmup = [[SetLogStore instance] createWithName:@"Squat" weight:N(100) reps:1 warmup:YES assistance:NO amrap:NO order:0];
    SetLog *work1 = [[SetLogStore instance] createWithName:@"Squat" weight:N(150) reps:2 warmup:NO assistance:NO amrap:NO order:1];
    SetLog *work2 = [[SetLogStore instance] createWithName:@"Squat" weight:N(175) reps:1 warmup:NO assistance:NO amrap:NO order:2];
    [workoutLog.sets addObjectsFromArray:@[warmup, work1, work2]];

    FTOWorkoutLogAmrapDataSource *dataSource = [[FTOWorkoutLogAmrapDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:SETS_SECTION], 1, @"");
    SetLogCell *cell = (SetLogCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([cell.weightLabel text], @"175 lbs", @"");
}

- (void)testHasMaxEstimateCell {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    SetLog *warmup = [[SetLogStore instance] createWithName:@"Squat" weight:N(100) reps:1 warmup:YES assistance:NO amrap:NO order:0];
    SetLog *work1 = [[SetLogStore instance] createWithName:@"Squat" weight:N(150) reps:2 warmup:NO assistance:NO amrap:NO order:1];
    SetLog *work2 = [[SetLogStore instance] createWithName:@"Squat" weight:N(175) reps:1 warmup:NO assistance:NO amrap:NO order:2];
    [workoutLog.sets addObjectsFromArray:@[warmup, work1, work2]];
    FTOWorkoutLogAmrapDataSource *dataSource = [[FTOWorkoutLogAmrapDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:ESTIMATED_MAX_SECTION], 1, @"");

    LogMaxEstimateCell *cell = (LogMaxEstimateCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:ESTIMATED_MAX_SECTION]];
    STAssertEqualObjects([cell.maxEstimate text], @"175 lbs", @"");
}

@end