#import "FTOCustomWorkoutViewController.h"
#import "FTOCustomWorkout.h"
#import "Workout.h"

@implementation FTOCustomWorkoutViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Week %@", self.customWorkout.week]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.customWorkout.workout sets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end