#import "FTOLiftWorkoutViewController.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "FTOWorkoutCell.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogStore.h"
#import "Set.h"

@implementation FTOLiftWorkoutViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.ftoWorkout.workout.sets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOWorkoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetCell"];
    if (!cell) {
        cell = [FTOWorkoutCell create];
    }

    [cell setSet:self.ftoWorkout.workout.sets[(NSUInteger) [indexPath row]]];
    return cell;
}

- (IBAction)doneButtonTapped:(id)sender {
    [self logWorkout];

}

- (void)logWorkout {
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";

    for (Set *set in self.ftoWorkout.workout.sets) {
        [log.sets addObject:[[SetLogStore instance] createFromSet:set]];
    }
}

@end