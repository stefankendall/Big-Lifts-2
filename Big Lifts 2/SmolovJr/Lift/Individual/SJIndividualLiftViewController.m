#import <MRCEnumerable/NSArray+Enumerable.h>
#import "SJIndividualLiftViewController.h"
#import "SJWorkout.h"
#import "Workout.h"
#import "SJSetCell.h"
#import "SJSetWeightViewController.h"
#import "Set.h"
#import "WorkoutLog.h"
#import "WorkoutLogStore.h"
#import "SetLogStore.h"
#import "SetLog.h"
#import "WeightRounder.h"
#import "IIViewDeckController.h"

@interface SJIndividualLiftViewController ()
@property(nonatomic, strong) NSDecimalNumber *liftedWeight;
@end

@implementation SJIndividualLiftViewController

- (IBAction)doneButtonTapped:(id)sender {
    [self logWorkout];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"sjTrackNav"]];
}

- (void)logWorkout {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    workoutLog.name = @"Smolov Jr";
    [[self.sjWorkout.workout.sets array] each:^(Set *set) {
        SetLog *setLog = [[SetLogStore instance] createFromSet:set];
        setLog.weight = [self minimumOrLiftedWeight];
        [workoutLog.sets addObject:setLog];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.sjWorkout.workout sets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SJSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SJSetCell.class)];
    if (!cell) {
        cell = [SJSetCell create];
    }

    [cell setSjWorkout:self.sjWorkout withSet:self.sjWorkout.workout.sets[(NSUInteger) [indexPath row]] withEnteredWeight:self.liftedWeight];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"sjSetWeightSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SJSetWeightViewController *controller = [segue destinationViewController];
    controller.delegate = self;
    controller.weight = [self minimumOrLiftedWeight];

    [super prepareForSegue:segue sender:sender];
}

- (NSDecimalNumber *)minimumOrLiftedWeight {
    if (!self.liftedWeight) {
        NSDecimalNumber *effectiveWeight = [self.sjWorkout.workout.sets[0] effectiveWeight];
        return [[WeightRounder new] round:[effectiveWeight decimalNumberByAdding:self.sjWorkout.minWeightAdd]];
    }
    else {
        return self.liftedWeight;
    }
}

- (void)weightChanged:(NSDecimalNumber *)weight {
    self.liftedWeight = weight;
}

@end