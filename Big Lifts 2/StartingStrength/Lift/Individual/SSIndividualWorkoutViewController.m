#import <IAPManager/IAPManager.h>
#import "SSIndividualWorkoutViewController.h"
#import "IIViewDeckController.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSSWorkoutSTore.h"
#import "JSSStateStore.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "SetCellWithPlates.h"
#import "JSetLogStore.h"
#import "JSetLog.h"
#import "JSSWorkout.h"
#import "JSSState.h"
#import "JWorkout.h"
#import "JSet.h"
#import "RestToolbar.h"
#import "BLTimer.h"

@implementation SSIndividualWorkoutViewController

- (void)viewDidLoad {
    self.workoutIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [[BLTimer instance] setObserver:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell bounds].size.height;
}

- (IBAction)nextButtonTapped:(id)sender {
    self.workoutIndex++;
    [self.tableView reloadData];

    if (self.workoutIndex == self.ssWorkout.workouts.count - 1) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped:)];
        [self navigationItem].rightBarButtonItem = doneButton;
    }
}

- (void)doneButtonTapped:(id)o {
    [self logWorkout];
    [self saveState];
    [[JSSWorkoutStore instance] incrementWeights:self.ssWorkout];
    UIViewController *controller = [[self navigationController] viewControllers][0];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [controller.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ssTrackViewController"]];
}

- (void)adjustAlternation {
    if ([self.ssWorkout.name isEqualToString:@"A"]) {
        JSSState *state = [[JSSStateStore instance] first];
        state.workoutAAlternation = [state.workoutAAlternation intValue] == 0 ? @1 : @0;
    }
}

- (void)saveState {
    JSSState *state = [[JSSStateStore instance] first];
    state.lastWorkout = self.ssWorkout;
    [self adjustAlternation];
}

- (void)logWorkout {
    JWorkoutLogStore *store = [JWorkoutLogStore instance];
    JWorkoutLog *log = [store create];
    log.name = @"Starting Strength";
    log.date = [NSDate date];

    for (JWorkout *workout in self.ssWorkout.workouts) {
        for (JSet *set in [workout workSets]) {
            JSetLog *setLog = [[JSetLogStore instance] createFromSet:set];
            [log addSet:setLog];
        }
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
        return [[[self getCurrentWorkout] sets] count];
    }
}

- (JWorkout *)getCurrentWorkout {
    return [self.ssWorkout.workouts count] > 0 ? self.ssWorkout.workouts[(NSUInteger) self.workoutIndex] : nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RestToolbar *toolbar = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RestToolbar.class)];

        if (!toolbar) {
            toolbar = [RestToolbar create];
        }

        [toolbar updateTime];
        [toolbar.timerButton addTarget:self action:@selector(goToTimer) forControlEvents:UIControlEventTouchUpInside];

        return toolbar;
    }
    else {
        Class setClass = [[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING] ? SetCellWithPlates.class : SetCell.class;
        SetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(setClass)];

        if (cell == nil) {
            cell = [setClass create];
        }
        JWorkout *workout = [self getCurrentWorkout];
        JSet *set = [workout.orderedSets objectAtIndex:(NSUInteger) [indexPath row]];
        [cell setSet:set];
        if ([set.percentage isEqual:N(100)]) {
            [cell.percentageLabel setHidden:YES];
        }
        else {
            [cell.percentageLabel setHidden:NO];
        }
        return cell;
    }
}

- (void)goToTimer {
    [self performSegueWithIdentifier:@"ssGoToTimer" sender:self];
}

- (void)timerTick {
    [self.tableView reloadRowsAtIndexPaths:@[NSIP(0, 0)] withRowAnimation:UITableViewRowAnimationNone];
}

@end