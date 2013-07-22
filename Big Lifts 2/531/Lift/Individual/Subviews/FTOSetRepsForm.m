#import "FTOSetRepsForm.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "TextViewInputAccessoryBuilder.h"
#import "SetRepsDelegate.h"
#import "UITableViewController+NoEmptyRows.h"

@implementation FTOSetRepsForm

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
    [self.repsField setDelegate:self];
    [self setupFields];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSNumber *reps = [NSNumber numberWithInt:[[textField text] intValue]];
    [self.delegate repsChanged:reps];
}

- (void)setupFields {
    Settings *settings = [[SettingsStore instance] first];
    NSString *weightText = [[self.set roundedEffectiveWeight] stringValue];
    [self.weightField setText:[NSString stringWithFormat:@"%@ %@", weightText, settings.units]];
    [self.repsField setPlaceholder:[self.set.reps stringValue]];
    if (self.previouslyEnteredReps > 0) {
        [self.repsField setText:[NSString stringWithFormat:@"%d", self.previouslyEnteredReps]];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end