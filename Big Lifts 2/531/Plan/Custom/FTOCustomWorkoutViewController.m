#import "FTOCustomWorkoutViewController.h"
#import "FTOCustomWorkout.h"
#import "Workout.h"
#import "FTOCustomSetCell.h"
#import "Set.h"
#import "FTOCustomSetViewController.h"
#import "SetStore.h"

@interface FTOCustomWorkoutViewController ()

@property(nonatomic, strong) Set *tappedSet;
@end

@implementation FTOCustomWorkoutViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
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
    if ([indexPath section] == 0) {
        FTOCustomSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomSetCell.class)];
        if (!cell) {
            cell = [FTOCustomSetCell create];
        }

        Set *set = [self.customWorkout.workout sets][(NSUInteger) [indexPath row]];
        [cell setSet:set];

        return cell;
    }
    else {
        return [self getAddCell:tableView];
    }
}

- (UITableViewCell *)getAddCell:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOCustomWorkoutAddSetCell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOCustomWorkoutAddSetCell"];
    }

    [[cell textLabel] setText:@"Add..."];
    [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
    [[cell textLabel] setTextColor:[UIColor darkTextColor]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
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
    Set *set = [[SetStore instance] create];
    [self.customWorkout.workout.sets addObject:set];
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
        int row = [indexPath row];
        Set *set = self.customWorkout.workout.sets[row];
        [self.customWorkout.workout.sets removeObjectAtIndex:row];
        [[SetStore instance] remove:set];
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


@end