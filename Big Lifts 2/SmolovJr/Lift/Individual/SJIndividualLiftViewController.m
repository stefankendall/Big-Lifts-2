#import <MRCEnumerable/NSArray+Enumerable.h>
#import <FlurrySDK/Flurry.h>
#import "SJIndividualLiftViewController.h"
#import "JSJWorkout.h"
#import "SJSetCell.h"
#import "SJSetWeightViewController.h"
#import "JSet.h"
#import "WeightRounder.h"
#import "IIViewDeckController.h"
#import "JSJWorkoutStore.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "SJSetCellWithPlates.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSetLog.h"
#import "JSetLogStore.h"
#import "JWorkout.h"
#import "DecimalNumberHandlers.h"
#import "SetClassGenerator.h"

@interface SJIndividualLiftViewController ()
@property(nonatomic, strong) NSDecimalNumber *liftedWeight;
@end

@implementation SJIndividualLiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNib:SJSetCell.class];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:@"Workout" withParameters:@{@"Name" : @"Smolov Jr"}];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [self.sjWorkout.workout.sets count];
}

- (IBAction)doneButtonTapped:(id)sender {
    [self logWorkout];
    self.sjWorkout.done = YES;
    [self checkForCompletion];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"sjTrackNav"]];
}

- (void)checkForCompletion {
    BOOL workoutsRemaining = [[[JSJWorkoutStore instance] findAll] detect:^BOOL(JSJWorkout *sjWorkout) {
        return !sjWorkout.done;
    }] != nil;
    if (!workoutsRemaining) {
        [[[JSJWorkoutStore instance] findAll] each:^(JSJWorkout *sjWorkout) {
            sjWorkout.done = NO;
        }];
    }
}

- (void)logWorkout {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.name = @"Smolov Jr";
    workoutLog.date = [NSDate new];
    [self.sjWorkout.workout.sets each:^(JSet *set) {
        JSetLog *setLog = [[JSetLogStore instance] createFromSet:set];
        setLog.weight = [self minimumOrLiftedWeight];
        [workoutLog addSet:setLog];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self restToolbar:tableView];
    }
    else {
        Class klass = [SetClassGenerator shouldUseBarLoading] ? SJSetCellWithPlates.class : SJSetCell.class;
        SJSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(klass)];
        if (!cell) {
            cell = [klass create];
        }
        [cell setSjWorkout:self.sjWorkout withSet:self.sjWorkout.workout.sets[(NSUInteger) [indexPath row]] withEnteredWeight:self.liftedWeight];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self tableView:tableView cellForRowAtIndexPath:indexPath] frame].size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"sjSetWeightSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"sjSetWeightSegue"]) {
        SJSetWeightViewController *controller = [segue destinationViewController];
        controller.delegate = self;
        controller.weight = [self minimumOrLiftedWeight];
    }

    [super prepareForSegue:segue sender:sender];
}

- (NSDecimalNumber *)minimumOrLiftedWeight {
    if (!self.liftedWeight) {
        NSDecimalNumber *effectiveWeight = [self.sjWorkout.workout.sets[0] effectiveWeight];
        return [[WeightRounder new] round:[effectiveWeight decimalNumberByAdding:self.sjWorkout.minWeightAdd withBehavior:DecimalNumberHandlers.noRaise]];
    }
    else {
        return self.liftedWeight;
    }
}

- (void)weightChanged:(NSDecimalNumber *)weight {
    self.liftedWeight = weight;
}

- (void)goToTimer {
    [self performSegueWithIdentifier:@"sjGoToTimer" sender:self];
}

- (NSArray *)getSharedWorkout {
    return @[self.sjWorkout.workout];
}

@end