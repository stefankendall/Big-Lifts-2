#import "TrackViewController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLogCell.h"
#import "SetLogCombiner.h"
#import "WorkoutLogTableDataSource.h"
#import "WorkoutLog.h"

@implementation TrackViewController

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    int rowCount = [self getRowCount:indexPath];

    CGFloat subCellHeight = [cell.workoutLogTableDataSource tableView:nil heightForRowAtIndexPath:indexPath];
    return rowCount * subCellHeight;
}

- (int)getRowCount:(NSIndexPath *)path {
    WorkoutLog *workoutLog = [self getLog][(NSUInteger) [path row]];
    return [[[SetLogCombiner new] combineSetLogs:workoutLog.sets] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getLog] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];

    if (cell == nil) {
        cell = [WorkoutLogCell create];
        [cell setWorkoutLog:[self getLog][(NSUInteger) [indexPath row]]];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        WorkoutLog *log = [self getLog][(NSUInteger) [indexPath row]];
        [[WorkoutLogStore instance] remove:log];
        [tableView reloadData];
    }
}

- (NSArray *)getLog {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end