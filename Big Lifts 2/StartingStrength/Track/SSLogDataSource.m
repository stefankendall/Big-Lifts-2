#import "SSLogDataSource.h"
#import "CustomTableViewCell.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogCell.h"

@implementation SSLogDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[WorkoutLogStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];

    if (cell == nil) {
        cell = [WorkoutLogCell createNewTextCellFromNib];
        [cell setWorkoutLog:[[WorkoutLogStore instance] atIndex:[indexPath row]]];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] atIndex:[indexPath row]];
    int numberOfSets = [[workoutLog sets] count];

    return numberOfSets * SET_LOG_CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}


@end