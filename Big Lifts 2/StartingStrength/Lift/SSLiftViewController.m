#import "SSLiftViewController.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "SSIndividualWorkoutViewController.h"
#import "SSState.h"
#import "SSStateStore.h"
#import "SSLiftSummaryCell.h"
#import "SSLiftToolbarCell.h"

@interface SSLiftViewController ()
@property(nonatomic) BOOL aWorkout;
@end

@implementation SSLiftViewController

- (void)viewWillAppear:(BOOL)animated {
    SSState *state = [[SSStateStore instance] first];
    if( state.lastWorkout ){
        self.aWorkout = [state.lastWorkout.name isEqualToString:@"B"];
    }
    else {
        self.aWorkout = YES;
    }

    [self switchWorkout];
}

- (void)switchWorkout {
    self.ssWorkout = [[SSWorkoutStore instance] activeWorkoutFor:self.aWorkout ? @"A" : @"B"];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ssSummaryNextSegue"]) {
        SSIndividualWorkoutViewController *controller = (SSIndividualWorkoutViewController *) segue.destinationViewController;
        controller.ssWorkout = self.ssWorkout;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        return [self.ssWorkout.workouts count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        SSLiftToolbarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SSLiftToolbarCell.class)];
        if (!cell) {
            cell = [SSLiftToolbarCell create];
        }
        [cell.workoutSelector setSelectedSegmentIndex:self.aWorkout ? 0 : 1];
        [cell.workoutSelector addTarget:self
                             action:@selector(workoutChanged:)
                   forControlEvents:UIControlEventValueChanged];
        return cell;
    }
    else {
        SSLiftSummaryCell *cell = (SSLiftSummaryCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SSLiftSummaryCell.class)];
        if (!cell) {
            cell = [SSLiftSummaryCell create];
        }
        [cell setWorkout:self.ssWorkout.workouts[(NSUInteger) [indexPath row]]];
        return cell;
    }
}

- (void)workoutChanged:(id)workoutControl {
    UISegmentedControl *workoutSegment = workoutControl;
    self.aWorkout = workoutSegment.selectedSegmentIndex == 0;
    [self switchWorkout];
}

@end