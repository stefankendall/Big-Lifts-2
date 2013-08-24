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

    Lift *lift = [self liftAtIndex:[indexPath row]];
    [cell.textField setText:lift.name];
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
    Lift *lift = [self liftAtIndex:[rowTextField.indexPath row]];
    [lift setName:[textField text]];
}

- (Lift *) liftAtIndex: (int) index {
    return [[FTOLiftStore instance] atIndex:index];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end