#import <MRCEnumerable/NSArray+Enumerable.h>
#import "SSLiftSummaryCell.h"
#import "SSLift.h"
#import "Workout.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation SSLiftSummaryCell

- (void)setWorkout:(Workout *)workout {
    Set *firstSet = workout.sets[0];
    [self.liftLabel setText:firstSet.lift.name];
    int worksetCount = [[[workout.sets array] select:^BOOL(Set *set) {
        return !set.warmup;
    }] count];
    [self.setsAndRepsLabel setText:[NSString stringWithFormat:@"%dx%d", worksetCount, [firstSet.reps intValue]]];

    Settings *settings = [[SettingsStore instance] first];
    [self.weightLabel setText:[NSString stringWithFormat:@"%.1f %@", [[firstSet effectiveWeight] doubleValue], settings.units]];
}

@end