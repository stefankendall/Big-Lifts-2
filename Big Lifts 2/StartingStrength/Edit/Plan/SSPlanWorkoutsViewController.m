#import "SSPlanWorkoutsViewController.h"
#import "SSWorkoutDataSource.h"

@implementation SSPlanWorkoutsViewController
@synthesize workoutADataSource, workoutBDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];

    [workoutATableView setDataSource:workoutADataSource];
    [workoutBTableView setDataSource:workoutBDataSource];
}
@end