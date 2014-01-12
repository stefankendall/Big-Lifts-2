#import "FTOCustomWeekSelectorViewController.h"
#import "JFTOCustomWorkoutStore.h"
#import "FTOCustomWorkoutViewController.h"
#import "JFTOCustomWorkout.h"
#import "FTOCustomWeekEditCell.h"
#import "RowTextField.h"
#import "JFTOWorkoutStore.h"
#import "AddCell.h"
#import "FTOCustomToolbar.h"
#import "JWorkoutStore.h"

@interface FTOCustomWeekSelectorViewController ()
@property(nonatomic, strong) JFTOCustomWorkout *tappedWorkout;
@end

@implementation FTOCustomWeekSelectorViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.tableView isEditing]) {
        return 1;
    }
    else {
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.tableView isEditing]) {
        return [[JFTOCustomWorkoutStore instance] count];
    }
    else {
        if (section == 0) {
            return 1;
        }
        else if (section == 1) {
            return [[JFTOCustomWorkoutStore instance] count];
        }
        else {
            return 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEditing]) {
        return [self editCell:tableView forIndexPath:indexPath];
    }
    else {
        if ([indexPath section] == 0) {
            FTOCustomToolbar *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomToolbar.class)];
            if (!cell) {
                cell = [FTOCustomToolbar create];
            }
            [cell.templateButton addTarget:self action:@selector(copyTemplate) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        else if ([indexPath section] == 1) {
            return [self viewCell:tableView forIndexPath:indexPath];
        }
        else {
            return [self addCell:tableView];
        }
    }
}

- (void)copyTemplate {
    [self performSegueWithIdentifier:@"ftoCustomCopyTemplate" sender:self];
}

- (UITableViewCell *)viewCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    JFTOCustomWorkout *customWorkout = [[JFTOCustomWorkoutStore instance] atIndex:[indexPath row]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOCustomWeekCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOCustomWeekCell"];
    }
    [[cell textLabel] setText:customWorkout.name];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (UITableViewCell *)editCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    JFTOCustomWorkout *customWorkout = [[JFTOCustomWorkoutStore instance] atIndex:[indexPath row]];
    FTOCustomWeekEditCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomWeekEditCell.class)];
    if (!cell) {
        cell = [FTOCustomWeekEditCell create];
    }
    cell.nameField.indexPath = indexPath;
    [cell.nameField setDelegate:self];
    [cell.nameField setText:customWorkout.name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    if (section == 1) {
        self.tappedWorkout = [[JFTOCustomWorkoutStore instance] atIndex:[indexPath row]];
        [self performSegueWithIdentifier:@"ftoCustomWeekSelectedSegue" sender:self];
    }
    else if (section == 2) {
        JFTOCustomWorkout *customWorkout = [[JFTOCustomWorkoutStore instance] create];
        customWorkout.name = @"New Week";
        NSNumber *max = [[JFTOCustomWorkoutStore instance] max:@"week"];
        NSNumber *week = max ? [NSNumber numberWithInt:[max intValue] + 1] : @1;
        customWorkout.week = week;
        customWorkout.order = week;
        customWorkout.workout = [[JWorkoutStore instance] create];
        [self.tableView reloadData];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoCustomWeekSelectedSegue"]) {
        FTOCustomWorkoutViewController *controller = [segue destinationViewController];
        controller.customWorkout = self.tappedWorkout;
    }

    [super prepareForSegue:segue sender:sender];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[JFTOCustomWorkoutStore instance] removeAtIndex:[indexPath row]];
        [[JFTOCustomWorkoutStore instance] reorderWeeks];
        [self.tableView reloadData];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        return UITableViewCellEditingStyleDelete;
    }
    else {
        return UITableViewCellEditingStyleNone;
    }
}

- (IBAction)editWeekTapped:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO];
        [self.editWeekButton setTitle:@"Edit Weeks"];
    }
    else {
        [self.tableView setEditing:YES];
        [self.editWeekButton setTitle:@"Done"];
    }

    [self.tableView reloadData];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    RowTextField *rowTextField = (RowTextField *) textField;
    if(rowTextField.indexPath.row >= [[JFTOCustomWorkoutStore instance] count]){
        return;
    }

    JFTOCustomWorkout *customWorkout = [[JFTOCustomWorkoutStore instance] atIndex:[rowTextField.indexPath row]];
    customWorkout.name = [rowTextField text];
}

- (UITableViewCell *)addCell:(UITableView *)tableView {
    AddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCell.class)];
    if (cell == nil) {
        cell = [AddCell create];
    }
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        [[JFTOWorkoutStore instance] switchTemplate];
    }
}

@end