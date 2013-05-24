#import "SSIndividualWorkoutViewController.h"
#import "SSWorkoutLiftDataSource.h"

@implementation SSIndividualWorkoutViewController
@synthesize workoutTable, workoutDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    SSIndividualWorkoutViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"ssWorkoutSummaryViewController"];

    workoutDataSource = [[SSWorkoutLiftDataSource alloc] initWithSsWorkout:[controller ssWorkout]];
    [workoutTable setDataSource:workoutDataSource];
}


@end