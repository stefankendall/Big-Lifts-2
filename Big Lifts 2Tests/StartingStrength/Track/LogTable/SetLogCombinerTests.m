#import "SetLogCombinerTests.h"
#import "JSetLogStore.h"
#import "JSetLog.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "SetLogCombiner.h"
#import "SetLogContainer.h"

@implementation SetLogCombinerTests

- (void)testCombinesIdenticalSets {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    JSetLog *set1 = [[JSetLogStore instance] create];
    set1.name = @"Squat";
    set1.reps = @3;
    set1.weight = N(100);
    [workoutLog addSet:set1];

    JSetLog *set2 = [[JSetLogStore instance] create];
    set2.name = @"Squat";
    set2.reps = @3;
    set2.weight = N(100);
    [workoutLog addSet:set2];

    NSArray *combined = [[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:@[set1, set2]]];
    STAssertEquals([combined count], (NSUInteger) 1, @"");
    SetLogContainer *setLogContainer = [combined objectAtIndex:0];
    STAssertTrue([setLogContainer isKindOfClass:SetLogContainer.class], @"");
    STAssertEquals([setLogContainer count], 2, @"");
}

- (void)testCombinesSequentialSets {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    JSetLog *set1 = [[JSetLogStore instance] create];
    set1.name = @"Squat";
    set1.reps = @3;
    set1.weight = N(100);
    [workoutLog addSet:set1];

    JSetLog *set2 = [[JSetLogStore instance] create];
    set2.name = @"Squat";
    set2.reps = @3;
    set2.weight = N(140);
    [workoutLog addSet:set2];

    JSetLog *set3 = [[JSetLogStore instance] create];
    set3.name = @"Squat";
    set3.reps = @3;
    set3.weight = N(100);
    [workoutLog addSet:set3];

    NSArray *combined = [[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:@[set1, set2, set3]]];
    STAssertEquals([combined count], (NSUInteger) 3, @"");
}

@end