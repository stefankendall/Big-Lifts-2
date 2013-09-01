#import "SJIndividualLiftViewController.h"
#import "SJWorkout.h"
#import "Workout.h"
#import "SJSetCell.h"
#import "SJSetWeightViewController.h"
#import "Set.h"

@interface SJIndividualLiftViewController ()
@property(nonatomic, strong) NSDecimalNumber *liftedWeight;
@end

@implementation SJIndividualLiftViewController

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
    if (!self.liftedWeight) {
        NSDecimalNumber *effectiveWeight = [self.sjWorkout.workout.sets[0] effectiveWeight];
        controller.weight = [effectiveWeight decimalNumberByAdding:self.sjWorkout.minWeightAdd];
    }
    else {
        controller.weight = self.liftedWeight;
    }

    [super prepareForSegue:segue sender:sender];
}

- (void)weightChanged:(NSDecimalNumber *)weight {
    self.liftedWeight = weight;
}

@end