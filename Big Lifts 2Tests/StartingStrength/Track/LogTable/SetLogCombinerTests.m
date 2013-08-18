#import "SetLogCombinerTests.h"
#import "SetLogStore.h"
#import "SetLog.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "BLStoreManager.h"
#import "SetLogCombiner.h"
#import "SetLogContainer.h"
#import "FTOTriumvirateStore.h"
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
    [workoutLog.sets addObject:set1];

    SetLog *set2 = [[SetLogStore instance] create];
    set2.name = @"Squat";
    [workoutLog.sets addObject:set2];

    NSArray *combined = [[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:@[set1, set2]]];
    STAssertEquals([combined count], (NSUInteger) 1, @"");
    SetLogContainer *setLogContainer = [combined objectAtIndex:0];
    STAssertTrue([setLogContainer isKindOfClass:SetLogContainer.class], @"");
    STAssertEquals([setLogContainer count], 2, @"");
}

- (void) testCombinesTriumvirate {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    [[FTOTriumvirateAssistance new] setup];
    [[[[[[FTOWorkoutStore instance] first] workout] sets] array] each:^(Set *set) {
        [workoutLog.sets addObject:[[SetLogStore instance] createFromSet:set]];
    }];

    NSArray *combined = [[SetLogCombiner new] combineSetLogs:workoutLog.sets];
    STAssertEquals([combined count], 3U, @"");
}

@end