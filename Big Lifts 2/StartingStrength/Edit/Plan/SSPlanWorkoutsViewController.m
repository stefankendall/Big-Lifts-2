#import "SSPlanWorkoutsViewController.h"
#import "SSWorkoutDataSource.h"

@implementation SSPlanWorkoutsViewController
@synthesize workoutADataSource, workoutBDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];

    workoutADataSource = [[SSWorkoutDataSource alloc] initWithName: @"A"];
    workoutBDataSource = [[SSWorkoutDataSource alloc] initWithName: @"B"];


    [workoutATableView setDataSource:workoutADataSource];
    [workoutBTableView setDataSource:workoutBDataSource];
}
@end