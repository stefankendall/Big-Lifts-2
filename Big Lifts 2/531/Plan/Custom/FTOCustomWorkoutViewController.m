#import "FTOCustomWorkoutViewController.h"
#import "FTOCustomWorkout.h"
#import "Workout.h"
#import "FTOCustomSetCell.h"
#import "Set.h"

@implementation FTOCustomWorkoutViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Week %@", self.customWorkout.week]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.customWorkout.workout sets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOCustomSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomSetCell.class)];
    if (!cell) {
        cell = [FTOCustomSetCell create];
    }

    Set *set = [self.customWorkout.workout sets][(NSUInteger) [indexPath row]];
    [cell setSet: set];

    return cell;
}

@end