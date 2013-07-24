#import "FTOWorkoutLogDataSourceTests.h"
#import "FTOWorkoutLogDataSource.h"
#import "WorkoutLogStore.h"
#import "SetLog.h"
#import "SetLogStore.h"
#import "WorkoutLog.h"

@implementation FTOWorkoutLogDataSourceTests

-(void) testReturnsWorkSets {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    SetLog *warmup = [[SetLogStore instance] create];
    warmup.warmup = YES;
    warmup.reps = @1;
    SetLog *work1 = [[SetLogStore instance] create];
    work1.warmup = NO;
    work1.reps = @2;
    work1.name = @"Squat";
    work1.weight = N(200);
    SetLog *work2 = [[SetLogStore instance] create];
    work2.warmup = NO;
    work2.reps = @3;
    work2.name = @"Squat";
    work2.weight = N(200);
    [workoutLog.sets addObjectsFromArray:@[warmup, work1, work2]];

    FTOWorkoutLogDataSource *dataSource = [[FTOWorkoutLogDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 2, @"");
}

- (void) testCombinesWorkSets {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    SetLog *work1 = [[SetLogStore instance] create];
    work1.reps = @3;
    work1.weight = N(100);
    work1.name = @"Squat";
    SetLog *work2 = [[SetLogStore instance] create];
    work2.reps = @3;
    work2.weight = N(100);
    work2.name = @"Squat";
    SetLog *work3 = [[SetLogStore instance] create];
    work3.reps = @1;
    work3.weight = N(100);

    [workoutLog.sets addObjectsFromArray:@[work1, work2, work3]];

    FTOWorkoutLogDataSource *dataSource = [[FTOWorkoutLogDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 2, @"");
}

@end