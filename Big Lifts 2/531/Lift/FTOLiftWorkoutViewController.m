#import "FTOLiftWorkoutViewController.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "FTOWorkoutCell.h"

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

@end