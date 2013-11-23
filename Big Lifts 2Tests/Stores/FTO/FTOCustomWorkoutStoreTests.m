#import "FTOCustomWorkoutStoreTests.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkout.h"
#import "Workout.h"

@implementation FTOCustomWorkoutStoreTests

- (void)testSetsUpDefaultData {
    NSArray *customWorkouts = [[FTOCustomWorkoutStore instance] findAll];
    STAssertEquals([customWorkouts count], 4U, @"");

    FTOCustomWorkout *customWorkout = customWorkouts[0];
    STAssertEquals([customWorkout.workout.orderedSets count], 6U, @"");
}

- (void)testRemovesDuplicates {
    FTOCustomWorkout *ftoCustomWorkout = [[FTOCustomWorkoutStore instance] create];
    ftoCustomWorkout.week = @1;

    STAssertEquals([[FTOCustomWorkoutStore instance] count], 5, @"");
    [[FTOCustomWorkoutStore instance] removeDuplicates];
    STAssertEquals([[FTOCustomWorkoutStore instance] count], 4, @"");
}

- (void)testMarksDeloadAndIncrementWeeksFromVariant {
    STFail(@"");
}

@end