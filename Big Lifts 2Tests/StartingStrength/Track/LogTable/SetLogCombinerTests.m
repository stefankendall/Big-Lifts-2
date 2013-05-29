#import "SetLogCombinerTests.h"
#import "SetLogStore.h"
#import "SetLog.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "BLStoreManager.h"
#import "SetLogCombiner.h"

@implementation SetLogCombinerTests

- (void)setUp {
    [[BLStoreManager instance] resetAllStores];
}

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
    STAssertTrue([[combined objectAtIndex:0] isKindOfClass:SetLog.class], @"");
}

@end