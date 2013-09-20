#import "FTOCustomWeekSelectorViewController.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkoutViewController.h"
#import "FTOCustomWorkout.h"
#import "FTOCustomWeekEditCell.h"
#import "RowTextField.h"
#import "WorkoutStore.h"
#import "FTOWorkoutStore.h"


@interface FTOCustomWeekSelectorViewController ()
@property(nonatomic, strong) FTOCustomWorkout *tappedWorkout;
@end

@implementation FTOCustomWeekSelectorViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.tableView isEditing]) {
        return 1;
    }
    else {
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [[FTOCustomWorkoutStore instance] count];
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEditing]) {
        return [self editCell:tableView forIndexPath:indexPath];
    }
    else {
        if ([indexPath section] == 0) {
            return [self viewCell:tableView forIndexPath:indexPath];
        }
        else {
            return [self addCell:tableView];
        }
    }
}

- (UITableViewCell *)viewCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] atIndex:[indexPath row]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOCustomWeekCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOCustomWeekCell"];
    }
    [[cell textLabel] setText:customWorkout.name];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (UITableViewCell *)editCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] atIndex:[indexPath row]];
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
    if ([indexPath section] == 0) {
        self.tappedWorkout = [[FTOCustomWorkoutStore instance] atIndex:[indexPath row]];
        [self performSegueWithIdentifier:@"ftoCustomWeekSelectedSegue" sender:self];
    }
    else {
        FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] create];
        customWorkout.name = @"New Week";
        NSNumber *max = [[FTOCustomWorkoutStore instance] max:@"week"];
        NSNumber *week = [NSNumber numberWithInt:[max intValue] + 1];
        customWorkout.week = week;
        customWorkout.order = week;
        customWorkout.workout = [[WorkoutStore instance] create];
        [self.tableView reloadData];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FTOCustomWorkoutViewController *controller = [segue destinationViewController];
    controller.customWorkout = self.tappedWorkout;

    [super prepareForSegue:segue sender:sender];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[FTOCustomWorkoutStore instance] removeAtIndex:[indexPath row]];
        [self recreateWeeks];
        [self.tableView reloadData];
    }
}

- (void)recreateWeeks {
    for (int week = 1; week < [[FTOCustomWorkoutStore instance] count]; week++) {
            FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] atIndex:week];
            customWorkout.week = [NSNumber numberWithInt:week];
            customWorkout.order = [NSNumber numberWithInt:week];
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
    FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] atIndex:[rowTextField.indexPath row]];
    customWorkout.name = [rowTextField text];
}

- (UITableViewCell *)addCell:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOWeekAddCell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOWeekAddCell"];
    }

    [[cell textLabel] setText:@"Add..."];
    [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
    [[cell textLabel] setTextColor:[UIColor darkTextColor]];

    return cell;
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        [[FTOWorkoutStore instance] switchTemplate];
    }
}

@end