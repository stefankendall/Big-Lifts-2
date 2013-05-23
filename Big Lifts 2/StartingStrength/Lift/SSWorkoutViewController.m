#import "SSWorkoutViewController.h"
#import "SSWorkoutLiftDataSource.h"

@implementation SSWorkoutViewController
@synthesize workoutTable, workoutDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];

    workoutDataSource = [SSWorkoutLiftDataSource new];
    [workoutTable setDataSource:workoutDataSource];
}


@end