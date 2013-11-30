#import <MRCEnumerable/NSArray+Enumerable.h>
#import "SSLiftSummaryCell.h"
#import "SSLift.h"
#import "Workout.h"
#import "Set.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation SSLiftSummaryCell

- (void)setWorkout:(Workout *)workout {
    Set *lastSet = [workout.orderedSets lastObject];
    [self.liftLabel setText:lastSet.lift.name];
    int worksetCount = [[workout.orderedSets select:^BOOL(Set *set) {
        return !set.warmup;
    }] count];

    if ([[lastSet reps] intValue] > 0) {
        [self.setsAndRepsLabel setText:[NSString stringWithFormat:@"%dx%d", worksetCount, [lastSet.reps intValue]]];
    }
    else {
        [self.setsAndRepsLabel setText:[NSString stringWithFormat:@"%dx", worksetCount]];
    }

    JSettings *settings = [[JSettingsStore instance] first];
    [self.weightLabel setText:[NSString stringWithFormat:@"%@ %@", [lastSet effectiveWeight], settings.units]];
}

@end