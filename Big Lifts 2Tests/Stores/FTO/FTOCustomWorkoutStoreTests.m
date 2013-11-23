#import "FTOCustomWorkoutStoreTests.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkout.h"
#import "Workout.h"
#import "FTOVariantStore.h"
#import "FTOVariant.h"

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
    [[FTOCustomWorkoutStore instance] setupVariant:FTO_VARIANT_SIX_WEEK];
    FTOCustomWorkout *week1Workout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    FTOCustomWorkout *week2Workout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    FTOCustomWorkout *week3Workout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@3][0];
    FTOCustomWorkout *week4Workout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@4][0];
    FTOCustomWorkout *week5Workout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@5][0];
    FTOCustomWorkout *week6Workout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@6][0];
    FTOCustomWorkout *week7Workout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@7][0];

    STAssertFalse(week1Workout.deload, @"");
    STAssertFalse(week1Workout.incrementAfterWeek, @"");

    STAssertFalse(week2Workout.deload, @"");
    STAssertFalse(week2Workout.incrementAfterWeek, @"");

    STAssertFalse(week3Workout.deload, @"");
    STAssertTrue(week3Workout.incrementAfterWeek, @"");

    STAssertFalse(week4Workout.deload, @"");
    STAssertFalse(week4Workout.incrementAfterWeek, @"");

    STAssertFalse(week5Workout.deload, @"");
    STAssertFalse(week5Workout.incrementAfterWeek, @"");

    STAssertFalse(week6Workout.deload, @"");
    STAssertFalse(week6Workout.incrementAfterWeek, @"");

    STAssertTrue(week7Workout.deload, @"");
    STAssertTrue(week7Workout.incrementAfterWeek, @"");
}

@end