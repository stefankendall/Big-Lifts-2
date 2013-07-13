#import "Lift.h"
#import "SSLiftSummaryCellTests.h"
#import "SSLiftSummaryCell.h"
#import "SSLiftStore.h"
#import "SSWorkout.h"
#import "SSWorkoutStore.h"
#import "Workout.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation SSLiftSummaryCellTests

- (void)testSetWorkoutSetsValues {
    SSLiftSummaryCell *cell = [SSLiftSummaryCell create];
    SSWorkout *workoutA = [[SSWorkoutStore instance] first];

    Settings *settings = [[SettingsStore instance] first];
    settings.units = @"kg";

    Set *set = [((Workout *) workoutA.workouts[0]).sets lastObject];
    set.percentage = N(100);
    set.lift.weight = N(200);
    [cell setWorkout:workoutA.workouts[0]];

    STAssertTrue([[cell liftLabel].text isEqualToString:set.lift.name], @"");
    STAssertTrue([[cell weightLabel].text isEqualToString:@"200 kg"], [cell weightLabel].text);
    STAssertTrue([[cell setsAndRepsLabel].text isEqualToString:@"3x5"], [cell setsAndRepsLabel].text);
}

- (void)testNegativeReps {
    SSLiftSummaryCell *cell = [SSLiftSummaryCell create];
    SSWorkout *workoutA = [[SSWorkoutStore instance] first];
    Workout *workout = workoutA.workouts[0];
    Set *set = [workout.sets lastObject];
    set.reps = @-1;
    [cell setWorkout:workout];

    STAssertEqualObjects([cell setsAndRepsLabel].text, @"3x", @"");
}

@end