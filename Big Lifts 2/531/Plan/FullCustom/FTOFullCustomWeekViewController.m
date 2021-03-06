#import <FlurrySDK/Flurry.h>
#import "FTOFullCustomWeekViewController.h"
#import "JFTOFullCustomWeek.h"
#import "JFTOFullCustomWeekStore.h"
#import "JFTOFullCustomWorkout.h"
#import "JLift.h"
#import "JFTOLift.h"
#import "FTOFullCustomWorkoutViewController.h"
#import "JFTOWorkoutStore.h"

@implementation FTOFullCustomWeekViewController

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"5/3/1_FullCustom_Week"];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        [[JFTOWorkoutStore instance] switchTemplate];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[JFTOFullCustomWeekStore instance] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[[JFTOFullCustomWeekStore instance] atIndex:section] workouts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOFullCustomWeekLiftNameCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOFullCustomWeekLiftNameCell"];
    }

    JFTOFullCustomWorkout *customWorkout = [self workoutForIndexPath:indexPath];
    if (customWorkout == nil) {
        [[cell textLabel] setText:@"Bad data"];
    }
    else {
        [[cell textLabel] setText:customWorkout.lift.name];
    }

    return cell;
}

- (JFTOFullCustomWorkout *)workoutForIndexPath:(NSIndexPath *)indexPath {
    JFTOFullCustomWeek *week = [[JFTOFullCustomWeekStore instance] atIndex:indexPath.section];
    return week.workouts[(NSUInteger) indexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[JFTOFullCustomWeekStore instance] atIndex:section] name];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tappedWorkout = [self workoutForIndexPath:indexPath];
    [self performSegueWithIdentifier:@"ftoFullCustomWorkoutSelected" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoFullCustomWorkoutSelected"]) {
        FTOFullCustomWorkoutViewController *controller = [segue destinationViewController];
        controller.customWorkout = self.tappedWorkout;
    }
}

@end