#import "SSIndividualWorkoutViewController.h"
#import "SSIndividualWorkoutDataSource.h"

@implementation SSIndividualWorkoutViewController
@synthesize workoutTable, individualWorkoutDataSource, ssWorkout;

- (void)viewDidLoad {
    [super viewDidLoad];

    individualWorkoutDataSource = [[SSIndividualWorkoutDataSource alloc] initWithSsWorkout:ssWorkout];
    [workoutTable setDataSource:individualWorkoutDataSource];
}


@end