#import "SJIndividualLiftViewController.h"
#import "SJWorkout.h"
#import "Workout.h"
#import "SJSetCell.h"

@implementation SJIndividualLiftViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.sjWorkout.workout sets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SJSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SJSetCell.class)];
    if (!cell) {
        cell = [SJSetCell create];
    }

    [cell setSjWorkout:self.sjWorkout withSet:self.sjWorkout.workout.sets[(NSUInteger) [indexPath row]]];
    return cell;
}

@end