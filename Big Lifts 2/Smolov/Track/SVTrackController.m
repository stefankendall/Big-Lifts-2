#import "SVTrackController.h"
#import "JWorkoutLogStore.h"
#import "CombinedSetWorkoutLogTableDataSource.h"
#import "WorkoutLogCell.h"
#import "JWorkoutLog.h"
#import "SetLogCombiner.h"

@implementation SVTrackController

- (NSArray *)getLog {
    return [[JWorkoutLogStore instance] findAllWhere:@"name" value:@"Smolov"];
}

- (int)getRowCount:(NSIndexPath *)path {
    JWorkoutLog *workoutLog = [self getLog][(NSUInteger) [path row]];
    return [[[SetLogCombiner new] combineSetLogs:workoutLog.orderedSets] count];
}

- (UITableViewCell *)getWorkoutLogCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(WorkoutLogCell.class)];
    if (!cell) {
        cell = [WorkoutLogCell create];
    }
    JWorkoutLog *workoutLog = [self getLog][(NSUInteger) [indexPath row]];
    [cell setWorkoutLog:workoutLog];
    cell.workoutLogTableDataSource = [[CombinedSetWorkoutLogTableDataSource alloc] initWithWorkoutLog:workoutLog];
    [cell.setTable setDataSource:cell.workoutLogTableDataSource];
    [cell.setTable setDelegate:cell.workoutLogTableDataSource];
    [cell.setTable reloadData];
    return cell;
}

@end