#import "FTOFullCustomWeekViewController.h"
#import "JFTOFullCustomWeek.h"
#import "JFTOFullCustomWeekStore.h"
#import "JFTOFullCustomWorkout.h"
#import "JLift.h"
#import "JFTOLift.h"

@implementation FTOFullCustomWeekViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[JFTOFullCustomWeekStore instance] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[[JFTOFullCustomWeekStore instance] atIndex:section] workouts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOFullCustomWeekCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOFullCustomWeekCell"];
    }

    JFTOFullCustomWorkout *customWorkout = [self workoutForIndexPath:indexPath];
    [[cell textLabel] setText:customWorkout.lift.name];

    return cell;
}

- (JFTOFullCustomWorkout *)workoutForIndexPath:(NSIndexPath *)indexPath {
    JFTOFullCustomWeek *week = [[JFTOFullCustomWeekStore instance] atIndex:indexPath.section];
    return week.workouts[(NSUInteger) indexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[JFTOFullCustomWeekStore instance] atIndex:section] name];
}

@end