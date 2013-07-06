#import "SSLiftSummaryCell.h"
#import "SSLift.h"
#import "Workout.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation SSLiftSummaryCell
@synthesize liftLabel, setsAndRepsLabel, weightLabel;

- (void)setWorkout:(Workout *)workout {
    Set *firstSet = workout.sets[0];
    [liftLabel setText:firstSet.lift.name];
    [setsAndRepsLabel setText:[NSString stringWithFormat:@"%dx%d", workout.sets.count, [firstSet.reps intValue]]];

    Settings *settings = [[SettingsStore instance] first];
    [weightLabel setText:[NSString stringWithFormat:@"%.1f %@", [[firstSet effectiveWeight] doubleValue], settings.units]];
}

@end