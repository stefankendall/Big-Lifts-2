#import "SetCell.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "Lift.h"

@implementation SetCell

- (void)setSet:(Set *)set {
    if ([[set reps] intValue] <= 0 && [set amrap]) {
        [self.repsLabel setText:@"AMRAP"];
    }
    else {
        [self.repsLabel setText:[self getRepsString:set]];
        if ([set amrap]) {
            [self.repsLabel setTextColor:[UIColor colorWithRed:0 green:170 / 255.0 blue:0 alpha:1]];
        }
    }

    Settings *settings = [[SettingsStore instance] first];
    NSString *weightText = [NSString stringWithFormat:@"%@ %@",
                                                      [set roundedEffectiveWeight], settings.units];
    [self.weightLabel setText:weightText];
    [self.liftLabel setText:[set lift].name];
    [self.optionalLabel setHidden:!set.optional];
}

- (void)setSet:(Set *)set withEnteredReps:(int)enteredReps {
    self.enteredReps = enteredReps;
    [self setSet:set];
}

- (NSString *)getRepsString:(Set *)set {
    if (self.enteredReps > 0) {
        return [NSString stringWithFormat:@"%dx", self.enteredReps];
    }

    int maxReps = [set.maxReps intValue];
    if (maxReps > 0) {
        return [NSString stringWithFormat:@"%d-%dx", [set.reps intValue], maxReps];
    }
    else {
        return [NSString stringWithFormat:@"%d%@", [set.reps intValue], set.amrap ? @"+" : @"x"];
    }
}

@end