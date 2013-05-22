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


@end