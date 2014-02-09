#import "SSEditSetForm.h"
#import "JSet.h"
#import "PaddingTextField.h"
#import "SetChangeDelegate.h"

@implementation SSEditSetForm

- (void)viewDidLoad {
    [self.repsField setDelegate:self];
    [self.weightField setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.repsField setText:[NSString stringWithFormat:@"%@", self.set.reps]];
    [self.weightField setText:[NSString stringWithFormat:@"%@", [self.set roundedEffectiveWeight]]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate weightChanged:[NSDecimalNumber decimalNumberWithString:[self.weightField text] locale:[NSLocale currentLocale]]];
    [self.delegate repsChanged:[NSNumber numberWithInt:[[self.repsField text] intValue]]];
}

@end