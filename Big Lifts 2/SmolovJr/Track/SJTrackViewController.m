#import "SJTrackViewController.h"
#import "JWorkoutLogStore.h"
#import "CombinedSetWorkoutLogTableDataSource.h"
#import "SetLogCombiner.h"
#import "JWorkoutLog.h"
#import "WorkoutLogCell.h"

@implementation SJTrackViewController

- (NSArray *)getLog {
    return [[JWorkoutLogStore instance] findAllWhere:@"name" value:@"Smolov Jr"];
}

- (int)getRowCount:(NSIndexPath *)path {
    JWorkoutLog *workoutLog = [self getLog][(NSUInteger) [path row]];
    return [[[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:workoutLog.orderedSets]] count];
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
    return cell;
}

@end