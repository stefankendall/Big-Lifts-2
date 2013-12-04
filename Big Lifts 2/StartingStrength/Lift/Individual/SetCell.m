#import "SetCell.h"
#import "JSet.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "JLift.h"

@implementation SetCell

- (void)setSet:(JSet *)set {
    [self setRepsLabelText:set];
    [self setPercentageLabelText:set];
    [self setWeightLabelText:set];
    [self.liftLabel setText:[set lift].name];
    [self.optionalLabel setHidden:!set.optional];
}

- (void)setWeightLabelText:(JSet *)set {
    if (!set.lift.usesBar && [[set roundedEffectiveWeight] isEqualToNumber:@0]) {
        [self.weightLabel setText:@""];
    }
    else {
        JSettings *settings = [[JSettingsStore instance] first];
        NSDecimalNumber *weight = [set roundedEffectiveWeight];
        if (self.enteredWeight) {
            weight = self.enteredWeight;
        }
        weight = weight == nil ? N(0) : weight;
        NSString *weightText = [NSString stringWithFormat:@"%@ %@", weight, settings.units];
        [self.weightLabel setText:weightText];
    }
}

- (void)setPercentageLabelText:(JSet *)set {
    if ([[set percentage] compare:N(0)] == NSOrderedDescending) {
        [self.percentageLabel setText:[NSString stringWithFormat:@"%@%%", [set.percentage stringValue]]];
    }
    else {
        [self.percentageLabel setText:@""];
    }
}

- (void)setRepsLabelText:(JSet *)set {
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

- (void)setSet:(JSet *)set withEnteredReps:(NSNumber *)enteredReps withEnteredWeight:(NSDecimalNumber *)weight {
    self.enteredReps = enteredReps;
    self.enteredWeight = weight;
    [self setSet:set];
}

- (NSString *)getRepsString:(JSet *)set {
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