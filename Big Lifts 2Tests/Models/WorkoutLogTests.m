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

@end