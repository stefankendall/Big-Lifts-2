#import "SSLiftSummaryCellTests.h"
#import "SSLiftSummaryCell.h"
#import "JSSLiftStore.h"
#import "JSSWorkoutStore.h"
#import "JWorkout.h"
#import "JSet.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "JSSWorkout.h"
#import "JLift.h"

@implementation SSLiftSummaryCellTests

- (void)testSetWorkoutSetsValues {
    SSLiftSummaryCell *cell = [SSLiftSummaryCell create];
    JSSWorkout *workoutA = [[JSSWorkoutStore instance] first];

    JSettings *settings = [[JSettingsStore instance] first];
    settings.units = @"kg";

    JSet *set = [((JWorkout *) workoutA.workouts[0]).sets lastObject];
    set.percentage = N(100);
    set.lift.weight = N(200.5);
    [cell setWorkout:workoutA.workouts[0]];

    STAssertTrue([[cell liftLabel].text isEqualToString:set.lift.name], @"");
    STAssertTrue([[cell weightLabel].text isEqualToString:@"200.5 kg"], [cell weightLabel].text);
    STAssertTrue([[cell setsAndRepsLabel].text isEqualToString:@"3x5"], [cell setsAndRepsLabel].text);
}

- (void)testNegativeReps {
    SSLiftSummaryCell *cell = [SSLiftSummaryCell create];
    JSSWorkout *workoutA = [[JSSWorkoutStore instance] first];
    JWorkout *workout = workoutA.workouts[0];
    JSet *set = [workout.sets lastObject];
    set.reps = @-1;
    [cell setWorkout:workout];

    STAssertEqualObjects([cell setsAndRepsLabel].text, @"3x", @"");
}

@end