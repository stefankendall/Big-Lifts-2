#import "SVLiftSelectorViewController.h"
#import "JSVWorkoutStore.h"
#import "SVLiftSelectorCell.h"
#import "JSVWorkout.h"

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
    NSArray *workoutsInCycle = [[JSVWorkoutStore instance] findAllWhere:@"cycle" value:[NSNumber numberWithInt:indexPath.section + 1]];
    JSVWorkout *workout = workoutsInCycle[(NSUInteger) indexPath.row];
    [cell.week setText:[workout.week stringValue]];
    [cell.day setText:[workout.day stringValue]];

    return cell;
}

@end