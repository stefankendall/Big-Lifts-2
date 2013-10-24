#import "SJWorkoutStoreTests.h"
#import "SJWorkoutStore.h"
#import "SJWorkout.h"
#import "NSArray+Utilities.h"
#import "Workout.h"
#import "SetData.h"
#import "Set.h"

@implementation SJWorkoutStoreTests

- (void)testSetsUpWorkouts {
    STAssertEquals( [[SJWorkoutStore instance] count], 12, @"");
    NSArray *week1Workouts = [[SJWorkoutStore instance] findAllWhere:@"week" value:@1];
    SJWorkout *firstWorkout = [week1Workouts firstObject];
    SJWorkout *lastWorkout = [week1Workouts lastObject];

    STAssertEquals([firstWorkout.workout.orderedSets count], 6U, @"");
    Set *firstWorkoutSet = [firstWorkout.workout.orderedSets firstObject];
    STAssertEquals([[firstWorkoutSet reps] intValue], 6, @"");

    STAssertEquals([lastWorkout.workout.orderedSets count], 10U, @"");
    Set *lastWorkoutSet = [lastWorkout.workout.orderedSets firstObject];
    STAssertEquals([[lastWorkoutSet reps] intValue], 3, @"");
}

@end