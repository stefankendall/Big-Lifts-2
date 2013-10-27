#import "SetLogCombinerTests.h"
#import "SetLogStore.h"
#import "SetLog.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogCombiner.h"
#import "SetLogContainer.h"
#import "FTOTriumvirateAssistance.h"
#import "FTOWorkoutStore.h"
#import "FTOTriumvirate.h"
#import "Workout.h"
#import "NSArray+Enumerable.h"

@implementation SetLogCombinerTests

- (void)testCombinesIdenticalSets {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    SetLog *set1 = [[SetLogStore instance] create];
    set1.name = @"Squat";
    set1.reps = @3;
    set1.weight = N(100);
    [workoutLog.sets addObject:set1];

    SetLog *set2 = [[SetLogStore instance] create];
    set2.name = @"Squat";
    set2.reps = @3;
    set2.weight = N(100);
    [workoutLog.sets addObject:set2];

    NSArray *combined = [[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:@[set1, set2]]];
    STAssertEquals([combined count], (NSUInteger) 1, @"");
    SetLogContainer *setLogContainer = [combined objectAtIndex:0];
    STAssertTrue([setLogContainer isKindOfClass:SetLogContainer.class], @"");
    STAssertEquals([setLogContainer count], 2, @"");
}

- (void)testCombinesSequentialSets {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    SetLog *set1 = [[SetLogStore instance] create];
    set1.name = @"Squat";
    set1.reps = @3;
    set1.weight = N(100);
    [workoutLog.sets addObject:set1];

    SetLog *set2 = [[SetLogStore instance] create];
    set2.name = @"Squat";
    set2.reps = @3;
    set2.weight = N(140);
    [workoutLog.sets addObject:set2];

    SetLog *set3 = [[SetLogStore instance] create];
    set3.name = @"Squat";
    set3.reps = @3;
    set3.weight = N(100);
    [workoutLog.sets addObject:set3];

    NSArray *combined = [[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:@[set1, set2, set3]]];
    STAssertEquals([combined count], (NSUInteger) 3, @"");
}

@end