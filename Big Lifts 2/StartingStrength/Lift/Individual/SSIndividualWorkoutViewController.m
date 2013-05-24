#import "SSIndividualWorkoutViewController.h"
#import "SSIndividualWorkoutDataSource.h"
#import "SSWorkout.h"

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
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:nil action:@selector(doneButtonTapped)];
        [self navigationItem].rightBarButtonItem = doneButton;
    }
}

- (void)doneButtonTapped {
    NSLog(@"Not crashing!");
}

@end