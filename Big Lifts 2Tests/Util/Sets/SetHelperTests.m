#import "SetHelperTests.h"
#import "SetHelper.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSetLogStore.h"

@implementation SetHelperTests

- (void) testFindsHeaviestAmrap {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[NSDate new]];
    JSetLog *setLog1 = [[JSetLogStore instance] createWithName:@"name" weight:N(100) reps:4 warmup:NO assistance:NO amrap:YES];
    JSetLog *setLog2 = [[JSetLogStore instance] createWithName:@"name" weight:N(100) reps:4 warmup:NO assistance:YES amrap:NO];
    [workoutLog.sets addObjectsFromArray: @[setLog1, setLog2]];
    JSetLog *heaviestAmrapSetLog = [[SetHelper new] heaviestAmrapSetLog:workoutLog.sets];
    STAssertEquals(heaviestAmrapSetLog, setLog1, @"");
}

@end