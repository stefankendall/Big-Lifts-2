#import "FTOWorkoutLogAmrapDataSourceTests.h"
#import "FTOWorkoutLogAmrapDataSource.h"
#import "JSetLogStore.h"
#import "JWorkoutLogStore.h"
#import "JSetLog.h"
#import "JWorkoutLog.h"
#import "SetLogCell.h"
#import "LogMaxEstimateCell.h"

@implementation FTOWorkoutLogAmrapDataSourceTests

- (void)testReturnsHeaviestAmrapSet {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    JSetLog *warmup = [[JSetLogStore instance] createWithName:@"Squat" weight:N(100) reps:1 warmup:YES assistance:NO amrap:NO];
    JSetLog *work1 = [[JSetLogStore instance] createWithName:@"Squat" weight:N(180) reps:2 warmup:NO assistance:NO amrap:YES];
    JSetLog *work2 = [[JSetLogStore instance] createWithName:@"Squat" weight:N(175) reps:1 warmup:NO assistance:NO amrap:YES];
    [workoutLog.sets addObjectsFromArray:@[warmup, work1, work2]];

    FTOWorkoutLogAmrapDataSource *dataSource = [[FTOWorkoutLogAmrapDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:SETS_SECTION], 1, @"");
    SetLogCell *cell = (SetLogCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([cell.weightLabel text], @"180 lbs", @"");
}

- (void)testReturnsLastSetIfNoAmrap {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    JSetLog *warmup = [[JSetLogStore instance] createWithName:@"Squat" weight:N(100) reps:1 warmup:YES assistance:NO amrap:NO];
    JSetLog *work1 = [[JSetLogStore instance] createWithName:@"Squat" weight:N(150) reps:2 warmup:NO assistance:NO amrap:NO];
    JSetLog *work2 = [[JSetLogStore instance] createWithName:@"Squat" weight:N(175) reps:1 warmup:NO assistance:NO amrap:NO];
    [workoutLog.sets addObjectsFromArray:@[warmup, work1, work2]];

    FTOWorkoutLogAmrapDataSource *dataSource = [[FTOWorkoutLogAmrapDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:SETS_SECTION], 1, @"");
    SetLogCell *cell = (SetLogCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([cell.weightLabel text], @"175 lbs", @"");
}

- (void)testHasMaxEstimateCell {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    JSetLog *warmup = [[JSetLogStore instance] createWithName:@"Squat" weight:N(100) reps:1 warmup:YES assistance:NO amrap:NO];
    JSetLog *work1 = [[JSetLogStore instance] createWithName:@"Squat" weight:N(150) reps:2 warmup:NO assistance:NO amrap:NO];
    JSetLog *work2 = [[JSetLogStore instance] createWithName:@"Squat" weight:N(175) reps:1 warmup:NO assistance:NO amrap:NO];
    [workoutLog.sets addObjectsFromArray:@[warmup, work1, work2]];
    FTOWorkoutLogAmrapDataSource *dataSource = [[FTOWorkoutLogAmrapDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:ESTIMATED_MAX_SECTION], 1, @"");

    LogMaxEstimateCell *cell = (LogMaxEstimateCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:ESTIMATED_MAX_SECTION]];
    STAssertEqualObjects([cell.maxEstimate text], @"175 lbs", @"");
}

@end