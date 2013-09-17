#import "FTOCustomSetViewController.h"
#import "Set.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation FTOCustomSetViewController

- (void)viewDidLoad {
    [self.repsLabel setDelegate:self];
    [self.percentageLabel setDelegate:self];
    [self.amrapSwitch addTarget:self action:@selector(amrapSwitchChange:) forControlEvents:UIControlEventValueChanged];

    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsLabel];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.percentageLabel];
}

- (void)amrapSwitchChange:(id)amrapSwitchChange {
    [self.set setAmrap:[self.amrapSwitch isOn]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    int reps = [[self.repsLabel text] intValue];
    NSDecimalNumber *percentage = [NSDecimalNumber decimalNumberWithString:[self.percentageLabel text]];
    [self.set setReps:[NSNumber numberWithInt:reps]];
    [self.set setPercentage:percentage];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.repsLabel setText:[NSString stringWithFormat:@"%@", self.set.reps]];
    [self.percentageLabel setText:[NSString stringWithFormat:@"%@", self.set.percentage]];
    [self.amrapSwitch setOn:self.set.amrap];
}

@end