#import <FlurrySDK/Flurry.h>
#import "FTOFullCustomWeekEditor.h"
#import "JFTOFullCustomWeekStore.h"
#import "FTOFullCustomWeekCell.h"
#import "PaddingRowTextField.h"
#import "JFTOFullCustomWeek.h"
#import "TextViewInputAccessoryBuilder.h"
#import "AddCell.h"

@implementation FTOFullCustomWeekEditor

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:@"5/3/1_FullCustom_WeekEditor"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [[JFTOFullCustomWeekStore instance] count];
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FTOFullCustomWeekCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOFullCustomWeekCell.class)];
        if (!cell) {
            cell = [FTOFullCustomWeekCell create];
        }

        JFTOFullCustomWeek *customWeek = [[JFTOFullCustomWeekStore instance] atIndex:indexPath.row];
        [cell.nameTextField setIndexPath:indexPath];
        [cell.nameTextField setText:customWeek.name];
        [cell.nameTextField setDelegate:self];
        [[TextViewInputAccessoryBuilder new] doneButtonAccessory:cell.nameTextField];
        return cell;
    }
    else {
        AddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCell.class)];
        if (!cell) {
            cell = [AddCell create];
        }
        return cell;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    PaddingRowTextField *paddingRowTextField = (PaddingRowTextField *) textField;
    JFTOFullCustomWeek *customWeek = [[JFTOFullCustomWeekStore instance] atIndex:[[paddingRowTextField indexPath] row]];
    if (customWeek) {
        customWeek.name = [paddingRowTextField text];
    }
}

- (IBAction)addDeleteButtonTapped:(id)sender {
    [self setEditing:!self.editing];
    if (self.editing) {
        [self.addDeleteButton setTitle:@"Done"];
    }
    else {
        [self.addDeleteButton setTitle:@"Delete"];
    }
    [self.tableView reloadData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[JFTOFullCustomWeekStore instance] removeAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self addWeek];
        [self.tableView reloadData];
    }
}

- (void)addWeek {
    JFTOFullCustomWeek *customWeek = [[JFTOFullCustomWeekStore instance] create];
    customWeek.name = @"New week";
    customWeek.incrementAfterWeek = NO;
    customWeek.week = [NSNumber numberWithInt:[[[JFTOFullCustomWeekStore instance] max:@"week"] intValue] + 1];
    [[JFTOFullCustomWeekStore instance] createWorkoutsForWeek:customWeek];
}

@end