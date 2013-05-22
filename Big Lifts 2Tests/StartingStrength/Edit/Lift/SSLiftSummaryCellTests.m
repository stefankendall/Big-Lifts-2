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

- (void) setUp{
    [super setUp];
    [[SettingsStore instance] reset];
}

- (void)testSetWorkoutSetsValues {
    SSLiftSummaryCell *cell = [SSLiftSummaryCell createNewTextCellFromNib];
    SSWorkout *workoutA = [[SSWorkoutStore instance] first];

    Settings * settings = [[SettingsStore instance] first];
    settings.units = @"kg";

    Set *set = ((Workout *)workoutA.workouts[0]).sets[0];
    set.weight = [NSNumber numberWithDouble:200];
    [cell setWorkout:workoutA.workouts[0]];

    STAssertTrue([[cell liftLabel].text isEqualToString:set.lift.name], @"");

    NSString *weightString = [cell weightLabel].text;
    STAssertTrue([weightString isEqualToString:@"200.0kg"], weightString);

    NSString *weightText = [cell weightLabel].text;
    STAssertTrue([weightText isEqualToString:@"200.0kg"], weightText);
}

@end