#import "SJSetWeightViewController.h"
#import "SetWeightDelegate.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation SJSetWeightViewController

- (void)viewDidLoad {
    [self.weightField setDelegate:self];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.weightField];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.weightField setText:[self.weight stringValue]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate weightChanged:
            [NSDecimalNumber decimalNumberWithString:[textField text]]];
}

@end