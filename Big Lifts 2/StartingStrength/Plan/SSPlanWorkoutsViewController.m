#import "SSPlanWorkoutsViewController.h"
#import "SSVariant.h"
#import "SSVariantStore.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "SSLift.h"

@implementation SSPlanWorkoutsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    SSVariant *variant = [[SSVariantStore instance] first];
    [self.variantButton setTitle:variant.name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self getWorkoutForSection:0] workouts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SSWorkoutCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SSWorkoutCell"];
        [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    }

    SSWorkout *workout = [self getWorkoutForSection:[indexPath section]];
    Workout *firstWorkout = workout.workouts[(NSUInteger) [indexPath row]];
    Set *firstSet = firstWorkout.sets[0];
    SSLift *lift = (SSLift *) firstSet.lift;

    [[cell textLabel] setText:lift.name];
    [cell setBackgroundColor:[UIColor whiteColor]];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Workout %@", section == 0 ? @"A" : @"B"];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if ([sourceIndexPath section] != [proposedDestinationIndexPath section]) {
        return sourceIndexPath;
    }

    return proposedDestinationIndexPath;
}


- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath {
    if ([sourceIndexPath row] == [destinationIndexPath row]) {
        return;
    }

    SSWorkout *workout = [self getWorkoutForSection:[sourceIndexPath section]];
    [workout.workouts exchangeObjectAtIndex:(NSUInteger) [sourceIndexPath row] withObjectAtIndex:(NSUInteger) [destinationIndexPath row]];
}

- (SSWorkout *)getWorkoutForSection:(int)section {
    return [[SSWorkoutStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", section == 0 ? @"A" : @"B"]];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end