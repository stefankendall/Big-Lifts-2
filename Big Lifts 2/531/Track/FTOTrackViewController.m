#import <FlurrySDK/Flurry.h>
#import "FTOTrackViewController.h"
#import "WorkoutLogCell.h"
#import "JWorkoutLog.h"
#import "FTOTrackToolbarCell.h"
#import "FTOEditLogViewController.h"
#import "JFTOSettingsStore.h"
#import "JSetLog.h"
#import "SetLogCombiner.h"
#import "FTOWorkoutLogAmrapDataSource.h"
#import "FTOWorkoutLogWorkSetsDataSource.h"
#import "JWorkoutLogStore.h"

@interface FTOTrackViewController ()
@property(nonatomic) JWorkoutLog *tappedLog;
@end

@implementation FTOTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showState = (ShowState) [[[[JFTOSettingsStore instance] first] logState] intValue];
    self.trackSort = (TrackSort) 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:@"5/3/1_Track"];
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
    NSArray *log = [[JWorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];

    if (self.trackSort == kNewest) {
        return log;
    }
    else {
        return [log sortedArrayUsingComparator:^NSComparisonResult(JWorkoutLog *log1, JWorkoutLog *log2) {
            JSetLog *setLog1 = [log1.sets firstObject];
            JSetLog *setLog2 = [log2.sets firstObject];
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
        JWorkoutLog *log = [self getLog][((NSUInteger) [path row])];
        return [[[SetLogCombiner new] combineSetLogs:[log workSets]] count];
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

        WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(WorkoutLogCell.class)];

        if (cell == nil) {
            cell = [WorkoutLogCell create];
        }

        JWorkoutLog *workoutLog = [self getLog][((NSUInteger) [indexPath row])];
        [cell setWorkoutLog:workoutLog];
        if (self.showState == kShowWorkSets) {
            cell.workoutLogTableDataSource = [[FTOWorkoutLogWorkSetsDataSource alloc] initWithWorkoutLog:workoutLog];
        }
        else if (self.showState == kShowAmrap) {
            cell.workoutLogTableDataSource = [[FTOWorkoutLogAmrapDataSource alloc] initWithWorkoutLog:workoutLog];
        }
        [cell.setTable setDataSource:cell.workoutLogTableDataSource];
        [cell.setTable setDelegate:cell.workoutLogTableDataSource];
        [cell.setTable reloadData];
        return cell;
    }
}

- (void)sortButtonTapped:(id)sortButtonTapped {
    self.trackSort = (self.trackSort + 1) % 2;
    [self.tableView reloadData];
}

- (void)viewButtonTapped:(id)sender {
    self.showState = (self.showState + 1) % 3;
    [[[JFTOSettingsStore instance] first] setLogState:@(self.showState)];
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
        FTOEditLogViewController *controller = [[UIStoryboard storyboardWithName:@"FTOEditLogViewController" bundle:nil] instantiateInitialViewController];
        controller.workoutLog = [self getLog][((NSUInteger) [indexPath row])];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end