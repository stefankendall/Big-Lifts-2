#import "SSPlanWorkoutsViewController.h"
#import "JSSVariantStore.h"
#import "JSSWorkoutStore.h"
#import "JWorkout.h"
#import "JSet.h"
#import "JSSLift.h"
#import "JSSWorkout.h"
#import "JSSVariant.h"

@implementation SSPlanWorkoutsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    JSSVariant *variant = [[JSSVariantStore instance] first];
    [self.variantButton setTitle:variant.name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[[JSSWorkoutStore instance] atIndex:section] workouts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SSWorkoutCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SSWorkoutCell"];
        [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    }

    int section = [indexPath section];
    JSSWorkout *workout = [[JSSWorkoutStore instance] atIndex:section];
    JWorkout *firstWorkout = workout.workouts[(NSUInteger) [indexPath row]];
    if ([firstWorkout.orderedSets count] > 0) {
        JSet *firstSet = firstWorkout.orderedSets[0];
        JSSLift *lift = (JSSLift *) firstSet.lift;
        [[cell textLabel] setText:lift.name];
    }
    else {
        [[cell textLabel] setText:@"No sets"];
    }

    [cell setBackgroundColor:[UIColor whiteColor]];


    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[JSSWorkoutStore instance] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    JSSWorkout *workout = [[JSSWorkoutStore instance] atIndex:section];
    return workout.name;
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

    int section = [sourceIndexPath section];
    JSSWorkout *workout = [[JSSWorkoutStore instance] atIndex:section];
    [workout.workouts exchangeObjectAtIndex:(NSUInteger) [sourceIndexPath row] withObjectAtIndex:(NSUInteger) [destinationIndexPath row]];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end