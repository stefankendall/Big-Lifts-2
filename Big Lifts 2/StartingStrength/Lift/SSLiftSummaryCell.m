#import <MRCEnumerable/NSArray+Enumerable.h>
#import "SSLiftSummaryCell.h"
#import "JSet.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "JLift.h"
#import "JWorkout.h"
#import "JSSLift.h"

@implementation SSLiftSummaryCell

- (void)setWorkout:(JWorkout *)workout {
    JSet *lastSet = [workout.sets lastObject];
    [self.liftLabel setText:[(JSSLift *) lastSet.lift effectiveName]];
    int worksetCount = [[workout.sets select:^BOOL(JSet *set) {
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