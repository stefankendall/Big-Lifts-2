#import "SSLiftViewController.h"
#import "SSLiftSummaryDataSource.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "SSIndividualWorkoutViewController.h"

@implementation SSLiftViewController

@synthesize ssLiftSummaryDataSource, workoutSummaryTable, ssWorkout;

- (void)viewDidLoad {
    [super viewDidLoad];

    ssWorkout = [[SSWorkoutStore instance] first];
    ssLiftSummaryDataSource = [[SSLiftSummaryDataSource alloc] initWithSsWorkout:ssWorkout];
    [workoutSummaryTable setDataSource:ssLiftSummaryDataSource];
}

- (IBAction)workoutValueChanged:(id)sender {
    UISegmentedControl *workoutSelector = sender;
    [self switchWorkoutToIndex:[workoutSelector selectedSegmentIndex]];
}

- (void)switchWorkoutToIndex:(int)index {
    SSWorkout *newSsWorkout = [[SSWorkoutStore instance] atIndex:index];
    ssWorkout = newSsWorkout;
    [ssLiftSummaryDataSource setSsWorkout:newSsWorkout];
    [workoutSummaryTable reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ssSummaryNextSegue"]){
        SSIndividualWorkoutViewController *controller = (SSIndividualWorkoutViewController *)segue.destinationViewController;
        controller.ssWorkout = ssWorkout;
    }
}

@end