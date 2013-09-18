#import "FTOCustomWorkoutViewController.h"
#import "FTOCustomWorkout.h"
#import "Workout.h"
#import "FTOCustomSetCell.h"
#import "Set.h"
#import "FTOCustomSetViewController.h"
#import "SetStore.h"

@interface FTOCustomWorkoutViewController()

@property(nonatomic, strong) Set *tappedSet;
@end

@implementation FTOCustomWorkoutViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Week %@", self.customWorkout.week]];
    [self.tableView reloadData];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tappedSet = self.customWorkout.workout.sets[(NSUInteger) [indexPath row]];
    [self performSegueWithIdentifier:@"ftoCustomSetSelectedSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FTOCustomSetViewController *controller = [segue destinationViewController];
    [controller setSet:self.tappedSet];
}

- (IBAction)addSet:(id)sender {
    Set *set = [[SetStore instance] create];
    [self.customWorkout.workout.sets addObject:set];
    [self.tableView reloadData];
}

@end