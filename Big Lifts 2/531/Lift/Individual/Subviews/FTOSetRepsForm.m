#import "FTOSetRepsForm.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "TextViewInputAccessoryBuilder.h"
#import "SetRepsDelegate.h"
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
    [self updateMaxForReps:[reps intValue]];
    [self.delegate repsChanged:reps];
}

- (void)setupFields {
    Settings *settings = [[SettingsStore instance] first];
    NSString *weightText = [[self.set roundedEffectiveWeight] stringValue];
    [self.weightField setText:[NSString stringWithFormat:@"%@ %@", weightText, settings.units]];

    int repsForMax = [self.set.reps intValue];
    [self.repsField setPlaceholder:[self.set.reps stringValue]];
    if (self.previouslyEnteredReps > 0) {
        [self.repsField setText:[NSString stringWithFormat:@"%d", self.previouslyEnteredReps]];
        repsForMax = self.previouslyEnteredReps;
    }
    [self updateMaxForReps:repsForMax];
}

- (void)updateMaxForReps:(int)reps {
    [self.oneRepField setText:[[[OneRepEstimator new] estimate:[self.set roundedEffectiveWeight] withReps:reps] stringValue]];
}

- (IBAction)liftIncomplete:(id)sender {
    [self.delegate repsChanged:@0];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end