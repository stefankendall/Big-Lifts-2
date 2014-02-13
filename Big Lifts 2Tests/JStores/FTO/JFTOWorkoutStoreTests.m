#import "JFTOWorkoutStoreTests.h"
#import "JFTOWorkoutStore.h"
#import "JFTOWorkout.h"
#import "JWorkoutStore.h"
#import "JWorkout.h"
#import "JFTOSetStore.h"
#import "JFTOSettingsStore.h"
#import "JFTOSettings.h"

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

- (void)testDoesNotLeakWorkouts {
    int workoutCount = [[JWorkoutStore instance] count];
    [[JFTOWorkoutStore instance] restoreTemplate];
    STAssertEquals(workoutCount, [[JWorkoutStore instance] count], @"");
}

- (void)testCreatesSixWeekDataProperly {
    [[[JFTOSettingsStore instance] first] setSixWeekEnabled:YES];
    [[JFTOWorkoutStore instance] switchTemplate];
    STAssertEquals([[JFTOWorkoutStore instance] count], 28, @"");
    NSArray *week6Workouts = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@6];
    STAssertEquals((int)[week6Workouts count], 4, @"");
    STAssertEquals((int) [[[JFTOWorkoutStore instance] unique:@"week"] count], 7, @"");
}

@end