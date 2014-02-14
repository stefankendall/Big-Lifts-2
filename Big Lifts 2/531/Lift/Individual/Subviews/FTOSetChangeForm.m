#import "FTOSetChangeForm.h"
#import "TextViewInputAccessoryBuilder.h"
#import "SetChangeDelegate.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "OneRepEstimator.h"
#import "JSet.h"

@implementation FTOSetChangeForm

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.weightField];
    [self.repsField setDelegate:self];
    [self.weightField setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupFields];
    [self.oneRepField setHidden:![[IAPAdapter instance] hasPurchased:IAP_1RM]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSNumber *reps = [NSNumber numberWithInt:[self currentReps]];
    [self updateMax];
    [self.delegate repsChanged:reps];
    [self.delegate weightChanged:self.currentWeight];
}

- (void)setupFields {
    [self.weightField setPlaceholder:[[self.set roundedEffectiveWeight] stringValue]];
    [self.repsField setPlaceholder:[self.set.reps stringValue]];
    if (self.previouslyEnteredReps > 0) {
        [self.repsField setText:[NSString stringWithFormat:@"%d", self.previouslyEnteredReps]];
    }
    if (self.previouslyEnteredWeight) {
        [self.weightField setText:[self.previouslyEnteredWeight stringValue]];
    }
    [self updateMax];
}

- (int)currentReps {
    NSString *repsText = [self.repsField text];
    if (![repsText isEqualToString:@""]) {
        return [repsText intValue];
    }
    else {
        return [self.set.reps intValue];
    }
}

- (NSDecimalNumber *)currentWeight {
    NSString *enteredWeightString = self.weightField.text;
    if (![enteredWeightString isEqualToString:@""]) {
        return [NSDecimalNumber decimalNumberWithString:enteredWeightString locale:NSLocale.currentLocale];
    }
    else {
        return [self.set roundedEffectiveWeight];
    }
}

- (void)updateMax {
    NSString *estimate = [[[OneRepEstimator new] estimate:self.currentWeight withReps:self.currentReps] stringValue];
    [self.oneRepField setText:estimate];
}

- (IBAction)liftIncomplete:(id)sender {
    [self.delegate repsChanged:@0];
    [self.navigationController popViewControllerAnimated:YES];
}

@end