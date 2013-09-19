#import "FTOCustomWeekSelectorViewController.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkoutViewController.h"
#import "FTOCustomWorkout.h"
#import "FTOCustomWeekEditCell.h"
#import "RowTextField.h"


@interface FTOCustomWeekSelectorViewController ()
@property(nonatomic, strong) FTOCustomWorkout *tappedWorkout;
@end

@implementation FTOCustomWeekSelectorViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FTOCustomWorkoutStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] atIndex:[indexPath row]];
    if ([tableView isEditing]) {
        FTOCustomWeekEditCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomWeekEditCell.class)];
        if (!cell) {
            cell = [FTOCustomWeekEditCell create];
        }
        cell.nameField.indexPath = indexPath;
        [cell.nameField setDelegate:self];
        [cell.nameField setText:customWorkout.name];
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOCustomWeekCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOCustomWeekCell"];
        }
        [[cell textLabel] setText:customWorkout.name];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tappedWorkout = [[FTOCustomWorkoutStore instance] atIndex:[indexPath row]];
    [self performSegueWithIdentifier:@"ftoCustomWeekSelectedSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FTOCustomWorkoutViewController *controller = [segue destinationViewController];
    controller.customWorkout = self.tappedWorkout;

    [super prepareForSegue:segue sender:sender];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[FTOCustomWorkoutStore instance] removeAtIndex:[indexPath row]];
        [self.tableView reloadData];
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
    FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] atIndex:[rowTextField.indexPath row]];
    customWorkout.name = [rowTextField text];
}


@end