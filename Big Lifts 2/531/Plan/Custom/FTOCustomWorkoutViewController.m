#import "FTOCustomWorkoutViewController.h"
#import "JFTOCustomWorkout.h"
#import "FTOCustomSetCell.h"
#import "JSet.h"
#import "FTOCustomSetViewController.h"
#import "JFTOSetStore.h"
#import "AddCell.h"
#import "FTOCustomWorkoutToolbar.h"
#import "JWorkout.h"

@interface FTOCustomWorkoutViewController ()

@property(nonatomic, strong) JSet *tappedSet;
@end

@implementation FTOCustomWorkoutViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return [[self.customWorkout.workout orderedSets] count];
    }
    else {
        return 1;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Week %@", self.customWorkout.week]];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FTOCustomWorkoutToolbar *toolbar = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomWorkoutToolbar.class)];
        if (!toolbar) {
            toolbar = [FTOCustomWorkoutToolbar create];
        }
        [toolbar.incrementAfterWeekSwitch setOn:self.customWorkout.incrementAfterWeek];
        [toolbar.incrementAfterWeekSwitch addTarget:self action:@selector(incrementAfterWeeksChange:) forControlEvents:UIControlEventValueChanged];
        return toolbar;
    }
    else if ([indexPath section] == 1) {
        FTOCustomSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomSetCell.class)];
        if (!cell) {
            cell = [FTOCustomSetCell create];
        }

        JSet *set = self.customWorkout.workout.orderedSets[(NSUInteger) [indexPath row]];
        [cell setSet:set];
        return cell;
    }
    else {
        AddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCell.class)];
        if (cell == nil) {
            cell = [AddCell create];
        }
        return cell;
    }
}

- (void)incrementAfterWeeksChange:(id)toggle {
    UISwitch *incrementSwitch = toggle;
    [self.customWorkout setIncrementAfterWeek:[incrementSwitch isOn]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1) {
        self.tappedSet = self.customWorkout.workout.orderedSets[(NSUInteger) [indexPath row]];
        [self performSegueWithIdentifier:@"ftoCustomSetSelectedSegue" sender:self];
    }
    else {
        [self addSet];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FTOCustomSetViewController *controller = [segue destinationViewController];
    [controller setSet:self.tappedSet];
}

- (void)addSet {
    [self.customWorkout.workout addSet:[[JFTOSetStore instance] create]];
    [self.tableView reloadData];
}

- (IBAction)deleteSets:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO];
        [self.deleteSetsButton setTitle:@"Delete Sets"];
    }
    else {
        [self.tableView setEditing:YES];
        [self.deleteSetsButton setTitle:@"Done"];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        JSet *set = self.customWorkout.workout.orderedSets[(NSUInteger) ([indexPath row])];
        [self.customWorkout.workout removeSet:set];
        [self.tableView reloadData];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1) {
        return UITableViewCellEditingStyleDelete;
    }
    else {
        return UITableViewCellEditingStyleNone;
    }
}


@end