#import <ViewDeck/IIViewDeckController.h>
#import "FTOLiftWorkoutViewController.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "FTOWorkoutCell.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogStore.h"
#import "Set.h"
#import "FTOLiftWorkoutToolbar.h"
#import "FTORepsToBeatCalculator.h"
#import "FTORepsToBeatBreakdown.h"
#import "FTOSetRepsForm.h"
#import "SetLog.h"
#import "FTOCycleAdjustor.h"
#import "SetCellWithPlates.h"
#import "IAPAdapter.h"
#import "Purchaser.h"

@interface FTOLiftWorkoutViewController ()

@property(nonatomic) NSMutableDictionary *lastSetReps;
@end

@implementation FTOLiftWorkoutViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.ftoWorkout.workout.sets count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = [indexPath row];

    if (row == 0) {
        FTOLiftWorkoutToolbar *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOLiftWorkoutToolbar"];
        if (!cell) {
            cell = [FTOLiftWorkoutToolbar create];
            Set *lastSet = [self.ftoWorkout.workout.sets lastObject];
            int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:lastSet.lift atWeight:[lastSet roundedEffectiveWeight]];
            [cell.repsToBeat setTitle:[NSString stringWithFormat:@"To Beat: %d", repsToBeat] forState:UIControlStateNormal];
            [cell.repsToBeat addTarget:self action:@selector(showRepsToBeatBreakdown:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
    else {
        Class setClass = [[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING] ? SetCellWithPlates.class : FTOWorkoutCell.class;
        SetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(setClass)];

        if (!cell) {
            cell = [setClass create];
        }

        [cell setSet:self.ftoWorkout.workout.sets[(NSUInteger) row - 1]];
        return cell;
    }
}

- (void)showRepsToBeatBreakdown:(id)showRepsToBeatBreakdown {
    [self performSegueWithIdentifier:@"ftoRepsToBeat" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoRepsToBeat"]) {
        FTORepsToBeatBreakdown *breakdown = [segue destinationViewController];
        [breakdown setLastSet:[self.ftoWorkout.workout.sets lastObject]];
    }
    else if ([[segue identifier] isEqualToString:@"ftoAmrapForm"]) {
        FTOSetRepsForm *form = [segue destinationViewController];
        Set *tappedSet = self.ftoWorkout.workout.sets[[self.tappedSetRow unsignedIntegerValue] - 1];
        [form setSet:tappedSet];
        [form setDelegate:self];
    }

    [super prepareForSegue:segue sender:sender];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Set *set = self.ftoWorkout.workout.sets[(NSUInteger) [indexPath row] - 1];
    if ([set amrap]) {
        self.tappedSetRow = [NSNumber numberWithInteger:[indexPath row]];
        [self performSegueWithIdentifier:@"ftoAmrapForm" sender:self];
    }
}

- (IBAction)doneButtonTapped:(id)sender {
    [self logWorkout];
    [self.ftoWorkout setDone:YES];
    [[FTOCycleAdjustor new] checkForCycleChange];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ftoTrackNavController"]];
}

- (void)setWorkout:(FTOWorkout *)ftoWorkout1 {
    self.ftoWorkout = ftoWorkout1;
    self.lastSetReps = [@{} mutableCopy];
}

- (void)logWorkout {
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";
    log.date = [NSDate new];

    NSMutableOrderedSet *sets = self.ftoWorkout.workout.sets;
    for (int i = 0; i < [sets count]; i++) {
        Set *set = sets[(NSUInteger) i];
        SetLog *setLog = [[SetLogStore instance] createFromSet:set];
        NSNumber *reps = self.lastSetReps[[NSNumber numberWithInt:(i + 1)]];
        if (reps) {
            setLog.reps = reps;
        }
        [log.sets addObject:setLog];
    }
}

- (void)repsChanged:(NSNumber *)reps {
    self.lastSetReps[self.tappedSetRow] = reps;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell bounds].size.height;
}

@end