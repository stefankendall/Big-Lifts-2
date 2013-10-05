#import "FTOTrackViewController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLogCell.h"
#import "FTOWorkoutLogWorkSetsDataSource.h"
#import "WorkoutLog.h"
#import "SetLogCombiner.h"
#import "FTOTrackToolbarCell.h"
#import "FTOEditLogViewController.h"
#import "FTOWorkoutLogAmrapDataSource.h"

typedef enum {
    kShowAll = 2,
    kShowWorkSets = 0,
    kShowAmrap = 1
} ShowState;

@interface FTOTrackViewController ()

@property(nonatomic) ShowState showState;
@property(nonatomic) WorkoutLog *tappedLog;
@end

@implementation FTOTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showState = kShowWorkSets;
}

- (NSArray *)getLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];
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
        [self setupDeleteButton:cell.deleteButton];
        self.viewButton = cell.viewButton;
        if (self.showState == kShowAll) {
            [self.viewButton setTitle:@"All" forState:UIControlStateNormal];
        }
        else if (self.showState == kShowWorkSets) {
            [self.viewButton setTitle:@"Work Sets" forState:UIControlStateNormal];
        }
        else {
            [self.viewButton setTitle:@"Last Set" forState:UIControlStateNormal];
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

- (void)viewButtonTapped:(id)sender {
    self.showState = (self.showState + 1) % 3;
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