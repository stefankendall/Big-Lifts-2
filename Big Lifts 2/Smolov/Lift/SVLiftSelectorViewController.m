#import "SVLiftSelectorViewController.h"
#import "JSVWorkoutStore.h"
#import "SVLiftSelectorCell.h"
#import "JSVWorkout.h"
#import "SVWorkoutViewController.h"

@implementation SVLiftSelectorViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *titles = @[@"Intro Microcycle", @"Base Mesocycle", @"Switching", @"Intense Mesocycle", @"Tapering"];
    return titles[(NSUInteger) section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int cycle = section + 1;
    NSArray *workoutsInCycle = [[JSVWorkoutStore instance] findAllWhere:@"cycle" value:[NSNumber numberWithInt:cycle]];
    return [workoutsInCycle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SVLiftSelectorCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SVLiftSelectorCell.class)];

    if (!cell) {
        cell = [SVLiftSelectorCell create];
    }
    JSVWorkout *workout = [self workoutForIndexPath:indexPath];
    [cell.week setText:[workout.week stringValue]];
    [cell.day setText:[workout.day stringValue]];
    if (workout.done) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedWorkout = [self workoutForIndexPath:indexPath];
    [self performSegueWithIdentifier:@"svSelectWorkout" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SVWorkoutViewController *controller = [segue destinationViewController];
    controller.svWorkout = self.selectedWorkout;
}

- (JSVWorkout *)workoutForIndexPath:(NSIndexPath *)indexPath {
    int cycle = indexPath.section + 1;
    NSArray *workoutsInCycle = [[JSVWorkoutStore instance] findAllWhere:@"cycle" value:[NSNumber numberWithInt:cycle]];
    return workoutsInCycle[(NSUInteger) indexPath.row];
}


@end