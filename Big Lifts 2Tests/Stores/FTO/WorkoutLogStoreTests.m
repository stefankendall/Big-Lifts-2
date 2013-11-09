#import "WorkoutLogStoreTests.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogStore.h"
#import "SetLog.h"

@implementation WorkoutLogStoreTests

- (void)testFixesBrokenOrderForStartingStrength {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] createWithName:@"Starting Strength" date:[NSDate new]];
    SetLog *bench1 = [[SetLogStore instance] create];
    bench1.name = @"Bench";

    SetLog *bench2 = [[SetLogStore instance] create];
    bench2.name = @"Bench";

    SetLog *squat1 = [[SetLogStore instance] create];
    squat1.name = @"Squat";

    SetLog *squat2 = [[SetLogStore instance] create];
    squat2.name = @"Squat";

    [workoutLog addSet:bench1];
    [workoutLog addSet:bench2];
    [workoutLog addSet:squat1];
    [workoutLog addSet:squat2];
    bench1.order = @0;
    bench2.order = @1;
    squat1.order = @0;
    squat2.order = @1;
    [[WorkoutLogStore instance] fixUnorderedStartingStrengthLogs];
    NSArray *expectedOrder = @[bench1, bench2, squat1, squat2];
    STAssertEqualObjects(workoutLog.orderedSets, expectedOrder, @"");
}

@end