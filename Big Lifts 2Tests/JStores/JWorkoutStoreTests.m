#import "JSet.h"
#import "JWorkoutStoreTests.h"
#import "JWorkoutStore.h"
#import "JWorkout.h"
#import "JSetStore.h"
#import "JLiftStore.h"

@implementation JWorkoutStoreTests

- (void)testCanInsertSetsAtStart {
    JWorkout *workout = [[JWorkoutStore instance] create];
    JSet *set1 = [[JSetStore instance] create];
    JSet *set2 = [[JSetStore instance] create];
    [workout addSets:@[set1, set2]];

    JSet *set3 = [[JSetStore instance] create];
    JSet *set4 = [[JSetStore instance] create];
    [workout addSets:@[set3, set4] atIndex:0];
    STAssertEquals(workout.sets[0], set3, @"");
    STAssertEquals(workout.sets[1], set4, @"");
    STAssertEquals(workout.sets[2], set1, @"");
    STAssertEquals(workout.sets[3], set2, @"");
}

- (void)testWorkoutsAreRemovedWhenAssociatedLiftsAreRemoved {
    JWorkout *workout = [[JWorkoutStore instance] create];
    JSet *set = [[JSetStore instance] create];
    JLift *lift = [[JLiftStore instance] create];
    set.lift = lift;
    [workout.sets addObject:set];
    [[JLiftStore instance] remove:lift];

    STAssertTrue([[[JWorkoutStore instance] findAll] containsObject:workout], @"");
    STAssertFalse([[[JSetStore instance] findAll] containsObject:set], @"");
    STAssertEquals([workout.sets count], (NSUInteger)0, @"");
}

@end