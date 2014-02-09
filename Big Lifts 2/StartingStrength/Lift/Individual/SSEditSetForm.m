#import "SSEditSetForm.h"
#import "JSet.h"
#import "PaddingTextField.h"
#import "SetChangeDelegate.h"
#import "TextViewInputAccessoryBuilder.h"
#import "SetChange.h"

@implementation SSEditSetForm

- (void)viewDidLoad {
    [self.repsField setDelegate:self];
    [self.weightField setDelegate:self];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.weightField];
}

- (void)viewWillAppear:(BOOL)animated {
    NSNumber *reps = self.previousChange ? self.previousChange.reps : self.set.reps;
    NSNumber *weight = self.previousChange ? self.previousChange.weight : [self.set roundedEffectiveWeight];
    [self.repsField setText:[NSString stringWithFormat:@"%@", reps]];
    [self.weightField setText:[NSString stringWithFormat:@"%@", weight]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate weightChanged:[NSDecimalNumber decimalNumberWithString:[self.weightField text] locale:[NSLocale currentLocale]]];
    [self.delegate repsChanged:[NSNumber numberWithInt:[[self.repsField text] intValue]]];
}

@end