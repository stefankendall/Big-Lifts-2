#import "FTOCustomWeekSelectorViewController.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkoutViewController.h"
#import "FTOCustomWorkout.h"


@interface FTOCustomWeekSelectorViewController ()
@property(nonatomic, strong) FTOCustomWorkout *tappedWorkout;
@end

@implementation FTOCustomWeekSelectorViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FTOCustomWorkoutStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOCustomWeekCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOCustomWeekCell"];
    }

    FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] atIndex:[indexPath row]];
    [[cell textLabel] setText:customWorkout.name];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tappedWorkout = [[FTOCustomWorkoutStore instance] atIndex: [indexPath row]];
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
}

@end