#import "JWorkout.h"
#import "JFTOCustomWorkoutStoreTests.h"
#import "JFTOCustomWorkoutStore.h"
#import "JFTOCustomWorkout.h"
#import "JFTOVariant.h"
#import "JWorkoutStore.h"

@implementation JFTOCustomWorkoutStoreTests

- (void)testSetsUpDefaultData {
    NSArray *customWorkouts = [[JFTOCustomWorkoutStore instance] findAll];
    STAssertEquals((int)[customWorkouts count], 4, @"");

    JFTOCustomWorkout *customWorkout = customWorkouts[0];
    STAssertEquals((int)[customWorkout.workout.sets count], 6, @"");
}

- (void)testMarksDeloadAndIncrementWeeksFromVariant {
    [[JFTOCustomWorkoutStore instance] setupVariant:FTO_VARIANT_SIX_WEEK];
    JFTOCustomWorkout *week1Workout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    JFTOCustomWorkout *week2Workout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    JFTOCustomWorkout *week3Workout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@3][0];
    JFTOCustomWorkout *week4Workout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@4][0];
    JFTOCustomWorkout *week5Workout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@5][0];
    JFTOCustomWorkout *week6Workout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@6][0];
    JFTOCustomWorkout *week7Workout = [[JFTOCustomWorkoutStore instance] findAllWhere:@"week" value:@7][0];

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

- (void) testDoesNotLeakWorkouts {
    [[JFTOCustomWorkoutStore instance] setupVariant:FTO_VARIANT_STANDARD];
    int workoutCount = [[JWorkoutStore instance] count];
    [[JFTOCustomWorkoutStore instance] setupVariant:FTO_VARIANT_STANDARD];
    STAssertEquals(workoutCount, [[JWorkoutStore instance] count], @"");
}

- (void) testReordersWeeksAfterCustomWorkoutIsRemoved {
    [[JFTOCustomWorkoutStore instance] setupVariant:FTO_VARIANT_STANDARD];
    [[JFTOCustomWorkoutStore instance] removeAtIndex:1];
    [[JFTOCustomWorkoutStore instance] reorderWeeks];
    
    JFTOCustomWorkout *customWorkout1 = [[JFTOCustomWorkoutStore instance] atIndex:0];
    JFTOCustomWorkout *customWorkout2 = [[JFTOCustomWorkoutStore instance] atIndex:1];

    STAssertEqualObjects(customWorkout1.week, @1, @"");
    STAssertEqualObjects(customWorkout2.week, @2, @"");
}

@end