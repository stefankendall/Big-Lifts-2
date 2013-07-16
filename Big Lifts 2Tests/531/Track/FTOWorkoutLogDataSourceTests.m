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
    SetLog *work1 = [[SetLogStore instance] create];
    work1.warmup = NO;
    SetLog *work2 = [[SetLogStore instance] create];
    work2.warmup = NO;
    [workoutLog.sets addObjectsFromArray:@[warmup, work1, work2]];

    FTOWorkoutLogDataSource *dataSource = [[FTOWorkoutLogDataSource alloc] initWithWorkoutLog:workoutLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 2, @"");
}

@end