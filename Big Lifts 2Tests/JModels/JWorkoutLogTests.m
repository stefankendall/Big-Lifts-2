#import "JWorkoutLogTests.h"
#import "JWorkoutLog.h"
#import "JWorkoutLogStore.h"
#import "JSetLogStore.h"
#import "JSetLog.h"

@implementation JWorkoutLogTests

- (void)testWorkSets {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    JSetLog *warmup = [[JSetLogStore instance] create];
    warmup.warmup = YES;
    JSetLog *workout = [[JSetLogStore instance] create];
    workout.warmup = NO;
    [workoutLog.sets addObjectsFromArray:@[warmup, workout]];
    STAssertEquals([[workoutLog workSets] count], 1U, @"");
}

- (void)testFindsBestSetFromWorkoutLog {
    JSetLog *set1 = [[JSetLogStore instance] create];
    set1.weight = N(200);
    set1.reps = @3;

    JSetLog *set2 = [[JSetLogStore instance] create];
    set2.weight = N(220);
    set2.reps = @2;

    JSetLog *set3 = [[JSetLogStore instance] create];
    set3.weight = N(200);
    set3.reps = @4;

    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    [workoutLog.sets addObjectsFromArray:@[set1, set2, set3]];

    STAssertEquals([workoutLog bestSet], set2, @"");
}

@end