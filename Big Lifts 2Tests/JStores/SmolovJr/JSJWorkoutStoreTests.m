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

    STAssertEquals((int)[firstWorkout.workout.orderedSets count], 6, @"");
    JSet *firstWorkoutSet = [firstWorkout.workout.orderedSets firstObject];
    STAssertEquals([[firstWorkoutSet reps] intValue], 6, @"");

    STAssertEquals((int)[lastWorkout.workout.orderedSets count], 10, @"");
    JSet *lastWorkoutSet = [lastWorkout.workout.orderedSets firstObject];
    STAssertEquals([[lastWorkoutSet reps] intValue], 3, @"");
}

@end