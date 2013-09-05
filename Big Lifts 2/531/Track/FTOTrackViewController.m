#import "FTOTrackViewController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLogCell.h"
#import "FTOWorkoutLogDataSource.h"
#import "WorkoutLog.h"
#import "SetLogCombiner.h"
#import "FTOTrackToolbarCell.h"
#import "FTOEditLogViewController.h"

@interface FTOTrackViewController ()

@property(nonatomic) BOOL showAll;
@property(nonatomic) WorkoutLog *tappedLog;
@end

@implementation FTOTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showAll = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        return [[self getLog] count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
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
    if (self.showAll) {
        return [super getRowCount:[NSIndexPath indexPathForRow:(NSUInteger) [path row] inSection:[path section]]];
    }
    else {
        WorkoutLog *log = [self getLog][((NSUInteger) [path row])];
        return [[[SetLogCombiner new] combineSetLogs:[[NSOrderedSet alloc] initWithArray:[log workSets]]] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        FTOTrackToolbarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOTrackToolbarCell.class)];
        if (!cell) {
            cell = [FTOTrackToolbarCell create];
        }
        [cell.viewButton addTarget:self action:@selector(viewButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        if([self.tableView isEditing] ){
            [cell.deleteButton setTitle:@"Done" forState:UIControlStateNormal];
        }
        else {
            [cell.deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        }
        self.viewButton = cell.viewButton;
        return cell;
    }
    else {
        if (self.showAll) {
            return [super tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(NSUInteger) [indexPath row] inSection:[indexPath section]]];
        }

        WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];

        if (cell == nil) {
            cell = [WorkoutLogCell create];
        }

        WorkoutLog *workoutLog = [self getLog][((NSUInteger) [indexPath row])];
        [cell setWorkoutLog:workoutLog];
        cell.workoutLogTableDataSource = [[FTOWorkoutLogDataSource alloc] initWithWorkoutLog:workoutLog];
        [cell.setTable setDataSource:cell.workoutLogTableDataSource];
        [cell.setTable setDelegate:cell.workoutLogTableDataSource];

        return cell;
    }
}

- (void)deleteButtonTapped:(id)deleteButtonTapped {
    FTOTrackToolbarCell *cell = (FTOTrackToolbarCell *) [self tableView:self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO];
    }
    else {
        [self.tableView setEditing:YES];
    }
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath section] == 0){
        return NO;
    }
    return YES;
}

- (void)viewButtonTapped:(id)sender {
    self.showAll = !self.showAll;
    NSString *nextState = self.showAll ? @"Work Sets" : @"All";
    [self.viewButton setTitle:nextState forState:UIControlStateNormal];
    [self.tableView reloadData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    return [super tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:[NSIndexPath indexPathForRow:[indexPath row] inSection:[indexPath section]]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tappedLog = [self getLog][((NSUInteger) [indexPath row])];
    [self performSegueWithIdentifier:@"ftoLogEdit" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ftoLogEdit"]) {
        FTOEditLogViewController *controller = [segue destinationViewController];
        controller.workoutLog = self.tappedLog;
    }
    [super prepareForSegue:segue sender:sender];
}

@end