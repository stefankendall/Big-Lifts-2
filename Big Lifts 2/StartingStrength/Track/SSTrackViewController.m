#import "SSTrackViewController.h"
#import "SSLogDataSource.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogTableDataSource.h"

@implementation SSTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ssLogDataSource = [SSLogDataSource new];
    [logTable setDataSource:ssLogDataSource];
    [logTable setDelegate:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [ssLogDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    int rowCount = [cell.workoutLogTableDataSource tableView:nil numberOfRowsInSection:0];
    return rowCount * [cell.workoutLogTableDataSource tableView:nil heightForRowAtIndexPath:indexPath];
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