#import "JSet.h"
#import "JWorkoutStoreTests.h"
#import "JWorkoutStore.h"
#import "JWorkout.h"
#import "JSetStore.h"

@implementation JWorkoutStoreTests

- (void)testSetsOrderOnSetsWhenAdding {
    JWorkout *workout = [[JWorkoutStore instance] create];
    JSet *set1 = [[JSetStore instance] create];
    JSet *set2 = [[JSetStore instance] create];
    JSet *set3 = [[JSetStore instance] create];

    [workout addSets:@[set1, set2, set3]];
    STAssertEquals([set1.order intValue], 0, @"" );
    STAssertEquals([set2.order intValue], 1, @"" );
    STAssertEquals([set3.order intValue], 2, @"" );
}

- (void)testFixesSetsWithBrokenOrderingOnLoad {
    JWorkout *workout = [[JWorkoutStore instance] create];
    JSet *set1 = [[JSetStore instance] create];
    JSet *set2 = [[JSetStore instance] create];
    JSet *set3 = [[JSetStore instance] create];
    [workout addSets:@[set1, set2, set3]];
    set1.order = nil;
    set2.order = nil;
    set3.order = nil;

    [[JWorkoutStore instance] onLoad];
    STAssertEquals([set1.order intValue], 0, @"" );
    STAssertEquals([set2.order intValue], 1, @"" );
    STAssertEquals([set3.order intValue], 2, @"" );
}

- (void)testRemovingSetsFixesOrdering {
    JWorkout *workout = [[JWorkoutStore instance] create];
    JSet *set1 = [[JSetStore instance] create];
    JSet *set2 = [[JSetStore instance] create];
    JSet *set3 = [[JSetStore instance] create];
    [workout addSets:@[set1, set2, set3]];
    [workout removeSet:set2];
    STAssertEquals([set3.order intValue], 1, @"" );
}

- (void)testSetsAreRetrievedByOrder {
    JWorkout *workout = [[JWorkoutStore instance] create];
    JSet *set1 = [[JSetStore instance] create];
    JSet *set2 = [[JSetStore instance] create];
    JSet *set3 = [[JSetStore instance] create];
    [workout addSets:@[set1, set2, set3]];

    set2.order = [NSNumber numberWithInt:0];
    set1.order = [NSNumber numberWithInt:1];
    STAssertEquals(workout.orderedSets[0], set2, @"");
    STAssertEquals(workout.orderedSets[1], set1, @"");
}

- (void)testCanInsertSetsAtStart {
    JWorkout *workout = [[JWorkoutStore instance] create];
    JSet *set1 = [[JSetStore instance] create];
    JSet *set2 = [[JSetStore instance] create];
    [workout addSets:@[set1, set2]];

    JSet *set3 = [[JSetStore instance] create];
    JSet *set4 = [[JSetStore instance] create];
    [workout addSets:@[set3, set4] atIndex:0];
    STAssertEquals(workout.orderedSets[0], set3, @"");
    STAssertEquals(workout.orderedSets[1], set4, @"");
    STAssertEquals(workout.orderedSets[2], set1, @"");
    STAssertEquals(workout.orderedSets[3], set2, @"");
}

@end