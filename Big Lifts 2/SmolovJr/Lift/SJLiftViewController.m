#import "SJLiftViewController.h"
#import "SJWorkoutStore.h"
#import "SJWorkoutSummaryCell.h"
#import "SJIndividualLiftViewController.h"

@interface SJLiftViewController()

@property(nonatomic, strong) SJWorkout *tappedWorkout;
@end

@implementation SJLiftViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[SJWorkoutStore instance] unique:@"week"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *workoutsInWeek = [[SJWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:(section + 1)]];
    return [workoutsInWeek count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SJWorkoutSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SJWorkoutSummaryCell.class)];
    if (!cell) {
        cell = [SJWorkoutSummaryCell create];
    }

    NSArray *workoutsInWeek = [[SJWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:([indexPath section] + 1)]];
    [cell setWorkout:workoutsInWeek[(NSUInteger) [indexPath row]]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Week %d", section + 1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *workoutsInWeek = [[SJWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:([indexPath section] + 1)]];
    self.tappedWorkout = workoutsInWeek[(NSUInteger) [indexPath row]];
    [self performSegueWithIdentifier:@"sjLiftSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SJIndividualLiftViewController *controller = [segue destinationViewController];
    controller.sjWorkout = self.tappedWorkout;
    [super prepareForSegue:segue sender:sender];
}

@end