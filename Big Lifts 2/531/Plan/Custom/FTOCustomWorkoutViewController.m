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

static const int kTOOLBAR_SECTION = 0;
static const int kSETS_SECTION = 1;
static const int kADD_SECTION = 2;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == kTOOLBAR_SECTION) {
        return 1;
    }
    else if (section == kSETS_SECTION) {
        return [[self.customWorkout.workout sets] count];
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
    if (indexPath.section == kTOOLBAR_SECTION) {
        FTOCustomWorkoutToolbar *toolbar = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomWorkoutToolbar.class)];
        if (!toolbar) {
            toolbar = [FTOCustomWorkoutToolbar create];
        }
        [toolbar.incrementAfterWeekSwitch setOn:self.customWorkout.incrementAfterWeek];
        [toolbar.incrementAfterWeekSwitch addTarget:self action:@selector(incrementAfterWeeksChange:) forControlEvents:UIControlEventValueChanged];
        return toolbar;
    }
    else if ([indexPath section] == kSETS_SECTION) {
        FTOCustomSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomSetCell.class)];
        if (!cell) {
            cell = [FTOCustomSetCell create];
        }

        JSet *set = self.customWorkout.workout.sets[(NSUInteger) [indexPath row]];
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
        self.tappedSet = self.customWorkout.workout.sets[(NSUInteger) [indexPath row]];
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
        JSet *set = self.customWorkout.workout.sets[(NSUInteger) ([indexPath row])];
        [self.customWorkout.workout removeSet:set];
        [self.tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == kSETS_SECTION;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)from toIndexPath:(NSIndexPath *)to {
    if (from.section == to.section) {
        if ([self.customWorkout.workout.sets count] > 1) {
            JSet *sourceSet = self.customWorkout.workout.sets[(NSUInteger) from.row];
            [self.customWorkout.workout.sets removeObjectAtIndex:(NSUInteger) from.row];
            [self.customWorkout.workout.sets insertObject:sourceSet atIndex:(NSUInteger) to.row];
        }
    }

    [self.tableView reloadData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == kSETS_SECTION) {
        return UITableViewCellEditingStyleDelete;
    }
    else {
        return UITableViewCellEditingStyleNone;
    }
}


@end