#import "WorkoutLogTests.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLog.h"
#import "SetLogStore.h"

@implementation WorkoutLogTests

- (void)testWorkSets {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    SetLog *warmup = [[SetLogStore instance] create];
    warmup.warmup = YES;
    SetLog *workout = [[SetLogStore instance] create];
    workout.warmup = NO;
    [workoutLog.sets addObjectsFromArray:@[warmup, workout]];
    STAssertEquals([[workoutLog workSets] count], 1U, @"");
}

- (void)testFindsBestSetFromWorkoutLog {
    SetLog *set1 = [[SetLogStore instance] create];
    set1.weight = N(200);
    set1.reps = @3;

    SetLog *set2 = [[SetLogStore instance] create];
    set2.weight = N(220);
    set2.reps = @2;

    SetLog *set3 = [[SetLogStore instance] create];
    set3.weight = N(200);
    set3.reps = @4;

    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    [workoutLog.sets addObjectsFromArray:@[set1, set2, set3]];

    STAssertEquals([workoutLog bestSet], set2, @"");
}

@end