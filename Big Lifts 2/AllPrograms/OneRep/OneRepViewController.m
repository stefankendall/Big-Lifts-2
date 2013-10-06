#import "OneRepViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "OneRepEstimator.h"

@implementation OneRepViewController

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.weightField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
    [self.weightField setDelegate:self];
    [self.repsField setDelegate:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:[self.weightField text]];
    int reps = [[self.repsField text] intValue];
    NSDecimalNumber *estimate = [[OneRepEstimator new] estimate:weight withReps:reps];
    if ([estimate compare:N(0)] == NSOrderedDescending) {
        [self.maxLabel setText:[estimate stringValue]];
    }
    else {
        [self.maxLabel setText:@""];
    }
}

@end