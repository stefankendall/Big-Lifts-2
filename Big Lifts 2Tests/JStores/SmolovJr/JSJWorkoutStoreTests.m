#import "JSJWorkoutStoreTests.h"
#import "JSJWorkoutStore.h"
#import "JSJWorkout.h"
#import "JWorkout.h"
#import "JSet.h"

@implementation JSJWorkoutStoreTests

- (void)testSetsUpWorkouts {
    STAssertEquals( [[JSJWorkoutStore instance] count], 12, @"");
    NSArray *week1Workouts = [[JSJWorkoutStore instance] findAllWhere:@"week" value:@1];
    JSJWorkout *firstWorkout = [week1Workouts firstObject];
    JSJWorkout *lastWorkout = [week1Workouts lastObject];

    STAssertEquals([firstWorkout.workout.orderedSets count], 6U, @"");
    JSet *firstWorkoutSet = [firstWorkout.workout.orderedSets firstObject];
    STAssertEquals([[firstWorkoutSet reps] intValue], 6, @"");

    STAssertEquals([lastWorkout.workout.orderedSets count], 10U, @"");
    JSet *lastWorkoutSet = [lastWorkout.workout.orderedSets firstObject];
    STAssertEquals([[lastWorkoutSet reps] intValue], 3, @"");
}

@end