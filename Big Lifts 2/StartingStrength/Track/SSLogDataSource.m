#import "SSLogDataSource.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogStore.h"
#import "WorkoutLogTableDataSource.h"

@implementation SSLogDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[WorkoutLogStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];

    if (cell == nil) {
        cell = [WorkoutLogCell create];
        [cell setWorkoutLog:[[WorkoutLogStore instance] atIndex:[indexPath row]]];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    int rowCount = [cell.workoutLogTableDataSource tableView:nil numberOfRowsInSection:0];
    return rowCount * [cell.workoutLogTableDataSource tableView:nil heightForRowAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}


@end