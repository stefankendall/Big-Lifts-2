#import "FTOCustomAssistanceEditLiftViewController.h"
#import "JFTOCustomAssistanceLift.h"
#import "TextViewInputAccessoryBuilder.h"
#import "PaddingTextField.h"

@implementation FTOCustomAssistanceEditLiftViewController

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:(id) self.name];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:(id) self.weight];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:(id) self.increment];

    [self.name setDelegate:self];
    [self.weight setDelegate:self];
    [self.increment setDelegate:self];
    [self.usesBar addTarget:self action:@selector(usesBarToggled:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.name setText:self.lift.name];
    [self.weight setText:[self.lift.weight stringValue]];
    [self.increment setText:[self.lift.increment stringValue]];
    [self.usesBar setOn:self.lift.usesBar];
}

- (void)usesBarToggled:(id)usesBarToggled {
    [self updateLift];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateLift];
}

- (void)updateLift {
    self.lift.name = [self.name text];
    self.lift.weight = self.weight.text ? [NSDecimalNumber decimalNumberWithString:[self.weight text]] : N(0);
    self.lift.increment = [NSDecimalNumber decimalNumberWithString:[self.increment text]];
    self.lift.usesBar = [self.usesBar isOn];
}

@end