#import "SSLiftViewController.h"
#import "SSLiftSummaryDataSource.h"
#import "SSWorkoutStore.h"

@implementation SSLiftViewController

@synthesize ssLiftSummaryDataSource, workoutSummaryTable;

- (void)viewDidLoad {
    [super viewDidLoad];

    ssLiftSummaryDataSource = [[SSLiftSummaryDataSource alloc] initWithSsWorkout:[[SSWorkoutStore instance] first]];
    [workoutSummaryTable setDataSource:ssLiftSummaryDataSource];
}


- (IBAction)workoutValueChanged:(id)sender {
    UISegmentedControl *workoutSelector = sender;
    [self switchWorkoutToIndex:[workoutSelector selectedSegmentIndex]];
}

- (void)switchWorkoutToIndex:(int)index {
    [ssLiftSummaryDataSource setSsWorkout:[[SSWorkoutStore instance] atIndex:index]];
    [workoutSummaryTable reloadData];
}

@end