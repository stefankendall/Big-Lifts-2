#import "JFTOWorkoutStoreTests.h"
#import "JFTOWorkoutStore.h"
#import "JFTOWorkout.h"
#import "JWorkoutStore.h"
#import "JWorkout.h"
#import "JFTOSetStore.h"

@implementation JFTOWorkoutStoreTests

- (void)testRemovesWorkoutsAndSetsOnRemove {
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] create];
    JWorkout *workout = [[JWorkoutStore instance] create];
    ftoWorkout.workout = workout;
    int workoutCount = [[JWorkoutStore instance] count];
    [ftoWorkout.workout addSet:[[JFTOSetStore instance] create]];
    int setCount = [[JFTOSetStore instance] count];

    [[JFTOWorkoutStore instance] remove:ftoWorkout];
    STAssertEquals(workoutCount - 1, [[JWorkoutStore instance] count], @"");
    STAssertEquals(setCount - 1, [[JFTOSetStore instance] count], @"");
}

@end