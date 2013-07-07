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
#import "BLStoreManager.h"

@implementation SSLiftSummaryCellTests

- (void)testSetWorkoutSetsValues {
    SSLiftSummaryCell *cell = [SSLiftSummaryCell create];
    SSWorkout *workoutA = [[SSWorkoutStore instance] first];

    Settings * settings = [[SettingsStore instance] first];
    settings.units = @"kg";

    Set *set = ((Workout *)workoutA.workouts[0]).sets[0];
    set.percentage = N(100);
    set.lift.weight = N(200);
    [cell setWorkout:workoutA.workouts[0]];

    STAssertTrue([[cell liftLabel].text isEqualToString:set.lift.name], @"");
    STAssertTrue([[cell weightLabel].text isEqualToString:@"200.0 kg"], [cell weightLabel].text);
    STAssertTrue([[cell setsAndRepsLabel].text isEqualToString:@"3x5"], [cell setsAndRepsLabel].text);
}

@end