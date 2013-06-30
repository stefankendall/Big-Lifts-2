#import "SSTrackViewController.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogTableDataSource.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogCombiner.h"

@implementation SSTrackViewController

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    int rowCount = [self getRowCount:indexPath];

    CGFloat subCellHeight = [cell.workoutLogTableDataSource tableView:nil heightForRowAtIndexPath:indexPath];
    return rowCount * subCellHeight;
}

- (int)getRowCount:(NSIndexPath *)path {
    WorkoutLog *workoutLog = [self getSsLog][(NSUInteger) [path row]];
    return [[[SetLogCombiner new] combineSetLogs:workoutLog.sets] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getSsLog] count];
}

- (NSArray *)getSsLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"Starting Strength"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];

    if (cell == nil) {
        cell = [WorkoutLogCell create];
        [cell setWorkoutLog:[self getSsLog][(NSUInteger) [indexPath row]]];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        WorkoutLog *log = [self getSsLog][(NSUInteger) [indexPath row]];
        [[WorkoutLogStore instance] remove:log];
        [tableView reloadData];
    }
}

@end