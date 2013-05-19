#import "SSPlanWorkoutsViewController.h"
#import "SSWorkoutDataSource.h"

@implementation SSPlanWorkoutsViewController
@synthesize workoutADataSource, workoutBDataSource;

- (void)viewDidLoad {
    [super viewDidLoad];

    workoutADataSource = [[SSWorkoutDataSource alloc] initWithName:@"A"];
    workoutBDataSource = [[SSWorkoutDataSource alloc] initWithName:@"B"];

    [workoutATableView setDataSource:workoutADataSource];
    [workoutBTableView setDataSource:workoutBDataSource];

    [workoutATableView setDelegate:self];
    [workoutBTableView setDelegate:self];

    [workoutATableView setEditing:YES];
    [workoutBTableView setEditing:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}




@end