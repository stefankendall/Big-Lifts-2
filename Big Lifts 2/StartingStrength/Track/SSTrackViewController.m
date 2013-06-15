#import "SSTrackViewController.h"
#import "SSLogDataSource.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogTableDataSource.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogCombiner.h"

@implementation SSTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ssLogDataSource = [SSLogDataSource new];
    [logTable setDataSource:ssLogDataSource];
    [logTable setDelegate:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [ssLogDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    int rowCount = [self getRowCount:indexPath];

    CGFloat subCellHeight = [cell.workoutLogTableDataSource tableView:nil heightForRowAtIndexPath:indexPath];
    CGFloat height = rowCount * subCellHeight;
    return height;
}

- (int)getRowCount:(NSIndexPath *)path {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] atIndex:[path row]];
    return [[[SetLogCombiner new] combineSetLogs:workoutLog.sets] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}

@end