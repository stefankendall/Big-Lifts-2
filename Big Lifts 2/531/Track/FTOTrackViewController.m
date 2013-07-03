#import "FTOTrackViewController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLogCell.h"
#import "FTOWorkoutLogDataSource.h"

@implementation FTOTrackViewController

- (NSArray *)getLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];
}

- (int)getRowCount:(NSIndexPath *)path {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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

@end