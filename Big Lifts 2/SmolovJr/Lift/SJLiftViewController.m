#import <FlurrySDK/Flurry.h>
#import "SJLiftViewController.h"
#import "SJWorkoutSummaryCell.h"
#import "SJIndividualLiftViewController.h"
#import "JSJWorkout.h"
#import "JSJWorkoutStore.h"

@interface SJLiftViewController()

@property(nonatomic, strong) JSJWorkout *tappedWorkout;
@end

@implementation SJLiftViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:@"SmolovJr_WorkoutSummary"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[JSJWorkoutStore instance] unique:@"week"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *workoutsInWeek = [[JSJWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:(section + 1)]];
    return [workoutsInWeek count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SJWorkoutSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SJWorkoutSummaryCell.class)];
    if (!cell) {
        cell = [SJWorkoutSummaryCell create];
    }

    NSArray *workoutsInWeek = [[JSJWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:([indexPath section] + 1)]];
    [cell setWorkout:workoutsInWeek[(NSUInteger) [indexPath row]]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Week %d", section + 1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *workoutsInWeek = [[JSJWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:([indexPath section] + 1)]];
    self.tappedWorkout = workoutsInWeek[(NSUInteger) [indexPath row]];
    [self performSegueWithIdentifier:@"sjLiftSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SJIndividualLiftViewController *controller = [segue destinationViewController];
    controller.sjWorkout = self.tappedWorkout;
    [super prepareForSegue:segue sender:sender];
}

- (void)goToTimer {
    [self performSegueWithIdentifier:@"sjGoToTimer" sender:self];
}

@end