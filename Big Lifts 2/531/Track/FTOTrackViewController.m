#import "FTOTrackViewController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLogCell.h"
#import "FTOWorkoutLogDataSource.h"

@interface FTOTrackViewController ()

@property(nonatomic) BOOL showAll;
@end

@implementation FTOTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showAll = NO;
}

- (NSArray *)getLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];
}

- (int)getRowCount:(NSIndexPath *)path {
    if (self.showAll) {
        return [super getRowCount: path];
    }

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.showAll) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }

    WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];

    if (cell == nil) {
        cell = [WorkoutLogCell create];
        WorkoutLog *workoutLog = [self getLog][(NSUInteger) [indexPath row]];
        [cell setWorkoutLog:workoutLog];
        cell.workoutLogTableDataSource = [[FTOWorkoutLogDataSource alloc] initWithWorkoutLog:workoutLog];
        [cell.setTable setDataSource:cell.workoutLogTableDataSource];
        [cell.setTable setDelegate:cell.workoutLogTableDataSource];
    }

    return cell;
}

- (IBAction)viewButtonTapped:(id)sender {
    self.showAll = !self.showAll;
    NSString *nextState = self.showAll ? @"All" : @"Last Set";
    [self.viewButton setTitle:nextState forState:UIControlStateNormal];
    [self.tableView reloadData];
}

@end