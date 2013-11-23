#import "FTOTrackViewController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLogCell.h"
#import "FTOWorkoutLogWorkSetsDataSource.h"
#import "WorkoutLog.h"
#import "SetLogCombiner.h"
#import "FTOTrackToolbarCell.h"
#import "FTOEditLogViewController.h"
#import "FTOWorkoutLogAmrapDataSource.h"
#import "FTOSettingsStore.h"
#import "SetLog.h"
#import "LogMaxEstimateCell.h"

@interface FTOTrackViewController ()
@property(nonatomic) WorkoutLog *tappedLog;
@end

@implementation FTOTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showState = (ShowState) [[[[FTOSettingsStore instance] first] logState] intValue];
    self.trackSort = (TrackSort) 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else {
        WorkoutLogCell *cell = (WorkoutLogCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
        CGFloat estMaxHeight = [cell.workoutLogTableDataSource tableView:nil heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:ESTIMATED_MAX_SECTION]];
        return [super tableView:tableView heightForRowAtIndexPath:indexPath] + estMaxHeight;
    }
}

- (NSArray *)getLog {
    NSArray *log = [[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];

    if (self.trackSort == kNewest) {
        return log;
    }
    else {
        return [log sortedArrayUsingComparator:^NSComparisonResult(WorkoutLog *log1, WorkoutLog *log2) {
            SetLog *setLog1 = [log1.orderedSets firstObject];
            SetLog *setLog2 = [log2.orderedSets firstObject];
            if ([setLog1.name isEqualToString:setLog2.name]) {
                return [log2.date compare:log1.date];
            }
            else {
                return [setLog1.name compare:setLog2.name];
            }
        }];
    }
}

- (int)getRowCount:(NSIndexPath *)path {
    if (self.showState == kShowAll) {
        return [super getRowCount:[NSIndexPath indexPathForRow:(NSUInteger) [path row] inSection:[path section]]];
    }
    else if (self.showState == kShowWorkSets) {
        WorkoutLog *log = [self getLog][((NSUInteger) [path row])];
        return [[[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:[log workSets]]] count];
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        FTOTrackToolbarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOTrackToolbarCell.class)];
        if (!cell) {
            cell = [FTOTrackToolbarCell create];
        }
        [cell.viewButton addTarget:self action:@selector(viewButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.sortButton addTarget:self action:@selector(sortButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self setupDeleteButton:cell.deleteButton];
        if (self.showState == kShowAll) {
            [cell.viewButton setTitle:@"All" forState:UIControlStateNormal];
        }
        else if (self.showState == kShowWorkSets) {
            [cell.viewButton setTitle:@"Work" forState:UIControlStateNormal];
        }
        else {
            [cell.viewButton setTitle:@"Last" forState:UIControlStateNormal];
        }

        if (self.trackSort == kNewest) {
            [cell.sortButton setTitle:@"Newest" forState:UIControlStateNormal];
        }
        else {
            [cell.sortButton setTitle:@"A-Z" forState:UIControlStateNormal];
        }

        return cell;
    }
    else {
        if (self.showState == kShowAll) {
            return [super tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(NSUInteger) [indexPath row] inSection:[indexPath section]]];
        }

        WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];

        if (cell == nil) {
            cell = [WorkoutLogCell create];
        }

        WorkoutLog *workoutLog = [self getLog][((NSUInteger) [indexPath row])];
        [cell setWorkoutLog:workoutLog];
        if (self.showState == kShowWorkSets) {
            cell.workoutLogTableDataSource = [[FTOWorkoutLogWorkSetsDataSource alloc] initWithWorkoutLog:workoutLog];
        }
        else if (self.showState == kShowAmrap) {
            cell.workoutLogTableDataSource = [[FTOWorkoutLogAmrapDataSource alloc] initWithWorkoutLog:workoutLog];
        }
        [cell.setTable setDataSource:cell.workoutLogTableDataSource];
        [cell.setTable setDelegate:cell.workoutLogTableDataSource];
        return cell;
    }
}

- (void)sortButtonTapped:(id)sortButtonTapped {
    self.trackSort = (self.trackSort + 1) % 2;
    [self.tableView reloadData];
}

- (void)viewButtonTapped:(id)sender {
    self.showState = (self.showState + 1) % 3;
    [[[FTOSettingsStore instance] first] setLogState:[NSNumber numberWithInt:self.showState]];
    [self.tableView reloadData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] > 0) {
        self.tappedLog = [self getLog][((NSUInteger) [indexPath row])];
        [self performSegueWithIdentifier:@"ftoLogEdit" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoLogEdit"]) {
        FTOEditLogViewController *controller = [segue destinationViewController];
        controller.workoutLog = self.tappedLog;
    }
    [super prepareForSegue:segue sender:sender];
}

@end