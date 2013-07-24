#import "FTOTrackViewController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLogCell.h"
#import "FTOWorkoutLogDataSource.h"
#import "WorkoutLog.h"
#import "SetLogCombiner.h"

@interface FTOTrackViewController ()

@property(nonatomic) BOOL showAll;
@end

@implementation FTOTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showAll = NO;
}

- (NSArray *)getLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];
}

- (int)getRowCount:(NSIndexPath *)path {
    if (self.showAll) {
        return [super getRowCount:path];
    }
    else {
        WorkoutLog *log = [self getLog][(NSUInteger) [path row]];
        return [[[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:[log workSets]]] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.showAll) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }

    WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];

    if (cell == nil) {
        cell = [WorkoutLogCell create];
    }

    WorkoutLog *workoutLog = [self getLog][(NSUInteger) [indexPath row]];
    [cell setWorkoutLog:workoutLog];
    cell.workoutLogTableDataSource = [[FTOWorkoutLogDataSource alloc] initWithWorkoutLog:workoutLog];
    [cell.setTable setDataSource:cell.workoutLogTableDataSource];
    [cell.setTable setDelegate:cell.workoutLogTableDataSource];

    return cell;
}

- (IBAction)viewButtonTapped:(id)sender {
    self.showAll = !self.showAll;
    NSString *nextState = self.showAll ? @"All" : @"Work Sets";
    [self.viewButton setTitle:nextState];
    [self.tableView reloadData];
}

@end