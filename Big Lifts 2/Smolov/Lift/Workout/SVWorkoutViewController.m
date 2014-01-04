#import "SVWorkoutViewController.h"
#import "JSVWorkout.h"
#import "JWorkout.h"
#import "SetCell.h"

@implementation SVWorkoutViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.svWorkout.testMax) {
        return 1;
    }
    else {
        return [self.svWorkout.workout.sets count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.svWorkout.testMax) {

    }
    else {
        SetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetCell.class)];
        if (!cell) {
            cell = [SetCell create];
        }

        [cell setSet:self.svWorkout.workout.sets[(NSUInteger) indexPath.row]];
        return cell;
    }
}

@end