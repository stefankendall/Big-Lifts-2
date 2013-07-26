#import "FTOTrackViewController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLogCell.h"
#import "FTOWorkoutLogDataSource.h"
#import "WorkoutLog.h"
#import "SetLogCombiner.h"
#import "FTOTrackToolbarCell.h"

@interface FTOTrackViewController ()

@property(nonatomic) BOOL showAll;
@end

@implementation FTOTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showAll = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getLog] count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 0) {
        return 40;
    }
    else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}


- (NSArray *)getLog {
    return [[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];
}

- (int)getRowCount:(NSIndexPath *)path {
    NSUInteger row = (NSUInteger) [path row] - 1;
    if (self.showAll) {
        return [super getRowCount:[NSIndexPath indexPathForRow:row inSection:[path section]]];
    }
    else {
        WorkoutLog *log = [self getLog][row];
        return [[[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:[log workSets]]] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 0) {
        FTOTrackToolbarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOTrackToolbarCell.class)];
        if (!cell) {
            cell = [FTOTrackToolbarCell create];
        }
        [cell.viewButton addTarget:self action:@selector(viewButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        self.viewButton = cell.viewButton;
        return cell;
    }
    else {
        NSUInteger row = (NSUInteger) [indexPath row] - 1;
        if (self.showAll) {
            return [super tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:[indexPath section]]];
        }

        WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];

        if (cell == nil) {
            cell = [WorkoutLogCell create];
        }

        WorkoutLog *workoutLog = [self getLog][row];
        [cell setWorkoutLog:workoutLog];
        cell.workoutLogTableDataSource = [[FTOWorkoutLogDataSource alloc] initWithWorkoutLog:workoutLog];
        [cell.setTable setDataSource:cell.workoutLogTableDataSource];
        [cell.setTable setDelegate:cell.workoutLogTableDataSource];

        return cell;
    }
}

- (void)viewButtonTapped:(id)sender {
    self.showAll = !self.showAll;
    NSString *nextState = self.showAll ? @"All" : @"Work Sets";
    [self.viewButton setTitle:nextState forState:UIControlStateNormal];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    return [super tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:[NSIndexPath indexPathForRow:[indexPath row] - 1 inSection:[indexPath section]]];
}

@end