#import "FTOPlanViewController.h"
#import "FTOSettingsStore.h"
#import "FTOSettings.h"
#import "UITableViewController+NoEmptyRows.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation FTOPlanViewController

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.trainingMaxField];
    [self.trainingMaxField setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    FTOSettings *settings = [[FTOSettingsStore instance] first];
    [self.trainingMaxField setText:[settings.trainingMax stringValue]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.trainingMaxField == textField) {
        FTOSettings *settings = [[FTOSettingsStore instance] first];
        settings.trainingMax = [NSDecimalNumber decimalNumberWithString:[textField text]];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end