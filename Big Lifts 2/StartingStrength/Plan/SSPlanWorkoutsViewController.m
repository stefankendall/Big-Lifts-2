#import "SSPlanWorkoutsViewController.h"
#import "SSWorkoutDataSource.h"

@implementation SSPlanWorkoutsViewController
@synthesize workoutDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];

    workoutDataSource = [SSWorkoutDataSource new];

    [workoutTableView setDataSource:workoutDataSource];
    [workoutTableView setDelegate:workoutDataSource];
    [workoutTableView setEditing:YES];
}

@end