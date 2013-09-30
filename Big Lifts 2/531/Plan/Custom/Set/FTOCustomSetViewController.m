#import "FTOCustomSetViewController.h"
#import "Set.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation FTOCustomSetViewController

- (void)viewDidLoad {
    [self.repsLabel setDelegate:self];
    [self.percentageLabel setDelegate:self];

    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsLabel];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.percentageLabel];
}

- (IBAction)amrapSwitchChange:(id)amrapSwitchChange {
    [self.set setAmrap:[self.amrapSwitch isOn]];
}

- (IBAction)warmupSwitchChange:(id)sender {
    [self.set setWarmup:[self.warmupSwitch isOn]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    int reps = [[self.repsLabel text] intValue];
    NSDecimalNumber *percentage = [NSDecimalNumber decimalNumberWithString:[self.percentageLabel text]];
    [self.set setReps:[NSNumber numberWithInt:reps]];
    [self.set setPercentage:percentage];
}

- (void)viewWillAppear:(BOOL)animated {
    NSString *repsText = [NSString stringWithFormat:@"%@", self.set.reps];
    if([self.set.reps intValue] == 0){
        repsText = @"";
    }
    [self.repsLabel setText:repsText];

    NSString *percentageText = [NSString stringWithFormat:@"%@", self.set.percentage];
    if([self.set.percentage intValue] == 0){
        percentageText = @"";
    }
    [self.percentageLabel setText:percentageText];
    [self.amrapSwitch setOn:self.set.amrap];
    [self.warmupSwitch setOn:self.set.warmup];
}

@end