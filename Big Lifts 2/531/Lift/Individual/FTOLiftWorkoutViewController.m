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

@interface FTOLiftWorkoutViewController ()

@property(nonatomic) UITextField *repsField;
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
        FTOWorkoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetCell"];
        if (!cell) {
            cell = [FTOWorkoutCell create];
        }
        [cell setSet:self.ftoWorkout.workout.sets[(NSUInteger) row - 1]];
        return cell;
    }
}

- (void)showRepsToBeatBreakdown:(id)showRepsToBeatBreakdown {
    [self performSegueWithIdentifier:@"ftoRepsToBeat" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FTORepsToBeatBreakdown *breakdown = [segue destinationViewController];
    [breakdown setLastSet: [self.ftoWorkout.workout.sets lastObject]];
    [super prepareForSegue:segue sender:sender];
}

- (IBAction)doneButtonTapped:(id)sender {
    [self logWorkout];
    [self.ftoWorkout setDone:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ftoTrackNavController"]];
}

- (void)logWorkout {
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";
    log.date = [NSDate new];

    for (Set *set in self.ftoWorkout.workout.sets) {
        [log.sets addObject:[[SetLogStore instance] createFromSet:set]];
    }
    Set *lastSet = [log.sets lastObject];
    int reps = [[self.repsField text] intValue];
    if (reps > 0) {
        lastSet.reps = [NSNumber numberWithInt:reps];
    }
}

@end