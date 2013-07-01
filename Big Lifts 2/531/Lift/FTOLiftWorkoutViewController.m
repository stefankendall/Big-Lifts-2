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

@interface FTOLiftWorkoutViewController ()

@property(nonatomic) int lastReps;
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
            self.lastReps = [lastSet.reps intValue];
            [cell.repsField setPlaceholder:lastSet.reps.stringValue];
            [cell.repsField setDelegate:self];
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.lastReps = [[textField text] intValue];
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

    for (Set *set in self.ftoWorkout.workout.sets) {
        [log.sets addObject:[[SetLogStore instance] createFromSet:set]];
    }
    Set *lastSet = [log.sets lastObject];
    lastSet.reps = [NSNumber numberWithInt:self.lastReps];
}

@end