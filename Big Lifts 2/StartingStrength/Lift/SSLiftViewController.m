#import "SSLiftViewController.h"
#import "SSLiftSummaryDataSource.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "SSIndividualWorkoutViewController.h"
#import "SSState.h"
#import "SSStateStore.h"

@implementation SSLiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ssLiftSummaryDataSource = [[SSLiftSummaryDataSource alloc] initWithSsWorkout:nil];
    [self.workoutSummaryTable setDataSource:self.ssLiftSummaryDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [self switchToAppropriateWorkout];
    [self.workoutSummaryTable reloadData];
}

- (void)switchToAppropriateWorkout {
    SSState *state = [[SSStateStore instance] first];
    BOOL aWorkout = [state.lastWorkout.name isEqualToString:@"A"];
    [self.workoutSelector setSelectedSegmentIndex:aWorkout ? 1 : 0];
    [self workoutValueChanged:self.workoutSelector];
}

- (IBAction)workoutValueChanged:(id)sender {
    UISegmentedControl *workoutSelector = sender;
    [self switchWorkoutToIndex:[workoutSelector selectedSegmentIndex]];
}

- (void)switchWorkoutToIndex:(int)index {
    NSString *name = index == 0 ? @"A" : @"B";

    self.ssWorkout = [[SSWorkoutStore instance] activeWorkoutFor: name];
    [self.ssLiftSummaryDataSource setSsWorkout:self.ssWorkout];
    [self.workoutSummaryTable reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ssSummaryNextSegue"]) {
        SSIndividualWorkoutViewController *controller = (SSIndividualWorkoutViewController *) segue.destinationViewController;
        controller.ssWorkout = self.ssWorkout;
    }
}

@end