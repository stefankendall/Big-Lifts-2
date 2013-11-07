#import "SSTrackViewController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogCombiner.h"
#import "WorkoutLogCell.h"
#import "SSWorkoutLogDataSource.h"

@implementation SSTrackViewController

- (NSArray *)getLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"Starting Strength"];
}

- (int)getRowCount:(NSIndexPath *)path {
    WorkoutLog *workoutLog = [self getLog][(NSUInteger) [path row]];
    return [[[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:workoutLog.orderedSets]] count];
}

- (UITableViewCell *)getWorkoutLogCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(WorkoutLogCell.class)];
    if (!cell) {
        cell = [WorkoutLogCell create];
    }
    WorkoutLog *workoutLog = [self getLog][(NSUInteger) [indexPath row]];
    [cell setWorkoutLog:workoutLog];
    cell.workoutLogTableDataSource = [[SSWorkoutLogDataSource alloc] initWithWorkoutLog:workoutLog];
    [cell.setTable setDataSource:cell.workoutLogTableDataSource];
    [cell.setTable setDelegate:cell.workoutLogTableDataSource];
    return cell;
}

@end