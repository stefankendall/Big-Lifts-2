#import "SJWorkoutStoreTests.h"
#import "SJWorkoutStore.h"
#import "SJWorkout.h"
#import "NSArray+Utilities.h"
#import "Workout.h"
#import "SetData.h"

@implementation SJWorkoutStoreTests

- (void)testSetsUpWorkouts {
    STAssertEquals( [[SJWorkoutStore instance] count], 12, @"");
    NSArray *week1Workouts = [[SJWorkoutStore instance] findAllWhere:@"week" value:@1];
    SJWorkout *firstWorkout = [week1Workouts firstObject];
    SJWorkout *lastWorkout = [week1Workouts lastObject];

    STAssertEquals([firstWorkout.workout.sets count], 6U, @"");
    STAssertEquals([[firstWorkout.workout.sets firstObject] reps], 6, @"");
    STAssertEquals([lastWorkout.workout.sets count], 10U, @"");
    STAssertEquals([[lastWorkout.workout.sets firstObject] reps], 3, @"");
}

@end