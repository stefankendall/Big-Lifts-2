#import "FTOSetRepsForm.h"
#import "Set.h"
#import "TextViewInputAccessoryBuilder.h"
#import "SetChangeDelegate.h"
#import "UITableViewController+NoEmptyRows.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "OneRepEstimator.h"

@implementation FTOSetRepsForm

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
    [self.repsField setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupFields];
    [self.oneRepField setHidden:![[IAPAdapter instance] hasPurchased:IAP_1RM]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSNumber *reps = [NSNumber numberWithInt:[[textField text] intValue]];
    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:[self.weightField text] locale:NSLocale.currentLocale];
    [self updateMaxForReps:[reps intValue]];
    [self.delegate repsChanged:reps];
    [self.delegate weightChanged:weight];
}

- (void)setupFields {
    [self.weightField setPlaceholder:[[self.set roundedEffectiveWeight] stringValue]];

    int repsForMax = [self.set.reps intValue];
    [self.repsField setPlaceholder:[self.set.reps stringValue]];
    if (self.previouslyEnteredReps > 0) {
        [self.repsField setText:[NSString stringWithFormat:@"%d", self.previouslyEnteredReps]];
        repsForMax = self.previouslyEnteredReps;
    }
    if (self.previouslyEnteredWeight) {
        [self.weightField setText:[self.previouslyEnteredWeight stringValue]];
    }
    [self updateMaxForReps:repsForMax];
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

- (void)updateMaxForReps:(int)reps {
    [self.oneRepField setText:[[[OneRepEstimator new] estimate:self.currentWeight withReps:reps] stringValue]];
}

- (IBAction)liftIncomplete:(id)sender {
    [self.delegate repsChanged:@0];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end