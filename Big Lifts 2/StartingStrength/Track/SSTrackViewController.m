#import "SSTrackViewController.h"
#import "SSLogDataSource.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogTableDataSource.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogCombiner.h"

@implementation SSTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ssLogDataSource = [SSLogDataSource new];
    [logTable setDataSource:ssLogDataSource];
    [logTable setDelegate:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [ssLogDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    int rowCount = [self getRowCount:indexPath];

    CGFloat subCellHeight = [cell.workoutLogTableDataSource tableView:nil heightForRowAtIndexPath:indexPath];
    CGFloat height = rowCount * subCellHeight;
    return height;
}

- (int)getRowCount:(NSIndexPath *)path {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] atIndex:[path row]];
    return [[[SetLogCombiner new] combineSetLogs:workoutLog.sets] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}

- (IBAction)editButtonTapped:(id)sender {
    [self replaceEditButtonWithDoneButton];
    [self.tableView setEditing:YES animated:YES];
}

- (void)doneTapped {
    [self replaceDoneButtonWithEditButton];
    [self.tableView setEditing:NO animated:YES];
}

- (void)replaceEditButtonWithDoneButton {
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(doneTapped)];
    [self.navigationItem setRightBarButtonItem:doneButton];
}

- (void)replaceDoneButtonWithEditButton {
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(editButtonTapped:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
}

@end