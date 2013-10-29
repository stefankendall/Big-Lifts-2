#import "FTOChangeLiftsViewController.h"
#import "FTOLiftStore.h"
#import "FTOChangeLiftCell.h"
#import "FTOLift.h"
#import "RowTextField.h"
#import "UITableViewController+NoEmptyRows.h"
#import "FTOWorkoutStore.h"
#import "AddCell.h"

@implementation FTOChangeLiftsViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([tableView isEditing]) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [[FTOLiftStore instance] count];
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
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
    else {
        AddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCell.class)];
        if (!cell) {
            cell = [AddCell create];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[FTOLiftStore instance] removeAtIndex:[indexPath row]];
        [[FTOWorkoutStore instance] switchTemplate];
        [self.tableView reloadData];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    RowTextField *rowTextField = (RowTextField *) textField;
    Lift *lift = [self liftAtIndex:[rowTextField.indexPath row]];
    [lift setName:[textField text]];
}

- (Lift *)liftAtIndex:(int)index {
    return [[FTOLiftStore instance] atIndex:index];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1) {
        [self performSegueWithIdentifier:@"ftoAddLiftSegue" sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (IBAction)arrangeButtonTapped:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO];
        [self.arrangeButton setTitle:@"Arrange"];
    }
    else {
        [self.tableView setEditing:YES];
        [self.arrangeButton setTitle:@"Done"];
    }

    [self.tableView reloadData];
}

- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath {
    int sourceRow = [sourceIndexPath row];
    int destRow = [destinationIndexPath row];
    if (sourceRow == destRow) {
        return;
    }

    FTOLift *source = [[FTOLiftStore instance] atIndex:sourceRow];
    FTOLift *dest = [[FTOLiftStore instance] atIndex:destRow];

    if( dest.order < source.order ){
        source.order = [NSNumber numberWithDouble:[dest.order doubleValue] - 0.5];
    } else {
        source.order = [NSNumber numberWithDouble:[dest.order doubleValue] + 0.5];
    }

    [self restitchLiftOrder];
}

- (void)restitchLiftOrder {
    NSArray *lifts = [[FTOLiftStore instance] findAll];
    for (int i = 0; i < [lifts count]; i++) {
        [lifts[(NSUInteger) i] setOrder:[NSNumber numberWithInt:i]];
    }
    [[FTOWorkoutStore instance] reorderWorkoutsToLifts];
}

@end