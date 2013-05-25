#import "SSIndividualWorkoutViewController.h"
#import "SSIndividualWorkoutDataSource.h"
#import "SSWorkout.h"
#import "SSMiddleViewController.h"
#import "IIViewDeckController.h"

@implementation SSIndividualWorkoutViewController
@synthesize workoutTable, individualWorkoutDataSource, ssWorkout, workoutIndex;

- (void)viewDidLoad {
    [super viewDidLoad];

    workoutIndex = 0;
    individualWorkoutDataSource = [[SSIndividualWorkoutDataSource alloc] initWithSsWorkout:ssWorkout];
    [workoutTable setDataSource:individualWorkoutDataSource];
    [workoutTable setDelegate:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}

- (IBAction)nextButtonTapped:(id)sender {
    workoutIndex++;

    [individualWorkoutDataSource setWorkoutIndex:workoutIndex];
    [workoutTable reloadData];

    if (workoutIndex == ssWorkout.workouts.count - 1) {
        NSLog(@"Setting done button");
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped:)];
        [self navigationItem].rightBarButtonItem = doneButton;
    }
}

- (void)doneButtonTapped:(id)o {
    SSMiddleViewController *controller = [[self navigationController] viewControllers][0];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [controller.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ssTrackViewController"]];
}

@end