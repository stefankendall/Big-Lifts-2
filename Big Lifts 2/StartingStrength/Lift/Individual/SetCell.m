#import "SetCell.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "Lift.h"

@implementation SetCell

- (void)setSet:(Set *)set {
    [self setRepsLabelText:set];
    [self setPercentageLabelText:set];
    [self setWeightLabelText:set];
    [self.liftLabel setText:[set lift].name];
    [self.optionalLabel setHidden:!set.optional];
}

- (void)setWeightLabelText:(Set *)set {
    if (!set.lift.usesBar && [[set roundedEffectiveWeight] isEqualToNumber:@0]) {
        [self.weightLabel setText:@""];
    }
    else {
        Settings *settings = [[SettingsStore instance] first];
        NSDecimalNumber *weight = [set roundedEffectiveWeight];
        if (self.enteredWeight) {
            weight = self.enteredWeight;
        }
        NSString *weightText = [NSString stringWithFormat:@"%@ %@", weight, settings.units];
        [self.weightLabel setText:weightText];
    }
}

- (void)setPercentageLabelText:(Set *)set {
    if ([[set percentage] compare:N(0)] == NSOrderedDescending) {
        [self.percentageLabel setText:[NSString stringWithFormat:@"%@%%", [set.percentage stringValue]]];
    }
    else {
        [self.percentageLabel setText:@""];
    }
}

- (void)setRepsLabelText:(Set *)set {
    if ([[set reps] intValue] <= 0 && [set amrap]) {
        [self.repsLabel setText:@"AMRAP"];
    }
    else {
        [self.repsLabel setText:[self getRepsString:set]];
        if ([set amrap]) {
            [self.repsLabel setTextColor:[UIColor colorWithRed:0 green:170 / 255.0 blue:0 alpha:1]];
        }
    }
}

- (void)setSet:(Set *)set withEnteredReps:(NSNumber *)enteredReps withEnteredWeight:(NSDecimalNumber *)weight {
    self.enteredReps = enteredReps;
    self.enteredWeight = weight;
    [self setSet:set];
}

- (NSString *)getRepsString:(Set *)set {
    if (self.enteredReps != nil) {
        return [NSString stringWithFormat:@"%@x", self.enteredReps];
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