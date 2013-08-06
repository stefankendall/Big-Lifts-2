#import "FTOChangeLiftsViewController.h"
#import "FTOLiftStore.h"
#import "FTOChangeLiftCell.h"
#import "FTOLift.h"
#import "RowTextField.h"
#import "UITableViewController+NoEmptyRows.h"
#import "FTOWorkoutStore.h"

@implementation FTOChangeLiftsViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FTOLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOChangeLiftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOChangeLiftCell.class)];
    if (!cell) {
        cell = [FTOChangeLiftCell create];
    }

    FTOLift *ftoLift = [[FTOLiftStore instance] atIndex:[indexPath row]];
    [cell.textField setText:ftoLift.name];
    [cell.textField setDelegate:self];
    [cell.textField setIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[FTOLiftStore instance] removeAtIndex:[indexPath row]];
        [[FTOWorkoutStore instance] switchTemplate];
        [self.tableView reloadData];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    RowTextField *rowTextField = (RowTextField *) textField;
    FTOLift *lift = [[FTOLiftStore instance] atIndex:[[rowTextField indexPath] row]];
    [lift setName:[textField text]];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end