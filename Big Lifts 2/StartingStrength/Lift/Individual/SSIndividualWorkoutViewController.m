#import "SSIndividualWorkoutViewController.h"
#import "SSIndividualWorkoutDataSource.h"

@implementation SSIndividualWorkoutViewController
@synthesize workoutTable, individualWorkoutDataSource, ssWorkout;

- (void)viewDidLoad {
    [super viewDidLoad];

    individualWorkoutDataSource = [[SSIndividualWorkoutDataSource alloc] initWithSsWorkout:ssWorkout];
    [workoutTable setDataSource:individualWorkoutDataSource];
    [workoutTable setDelegate:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}


@end