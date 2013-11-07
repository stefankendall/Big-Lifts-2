#import "TrackViewController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLogCell.h"
#import "SetLogCombiner.h"
#import "WorkoutLogTableDataSource.h"
#import "WorkoutLog.h"
#import "TrackToolbarCell.h"

@implementation TrackViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        UITableViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.bounds.size.height;
    }
    else {
        WorkoutLogCell *cell = (WorkoutLogCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
        int rowCount = [self getRowCount:indexPath];

        CGFloat subCellHeight = [cell.workoutLogTableDataSource tableView:nil heightForRowAtIndexPath:indexPath];
        return rowCount * subCellHeight;
    }
}

- (int)getRowCount:(NSIndexPath *)path {
    WorkoutLog *workoutLog = [self getLog][(NSUInteger) [path row]];
    return [workoutLog.orderedSets count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        return [[self getLog] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        TrackToolbarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TrackToolbarCell.class)];
        if (!cell) {
            cell = [TrackToolbarCell create];
        }
        [self setupDeleteButton:cell.deleteButton];
        return cell;
    }
    else {
        return [self getWorkoutLogCell:tableView indexPath:indexPath];
    }
}

- (UITableViewCell *)getWorkoutLogCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(WorkoutLogCell.class)];
    if (!cell) {
            cell = [WorkoutLogCell create];
        }
    [cell setWorkoutLog:[self getLog][(NSUInteger) [indexPath row]]];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == tableView.numberOfSections - 1) {
        return 1;
    }
    return 0;
}

- (void)setupDeleteButton:(UIButton *)deleteButton {
    [deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.tableView isEditing]) {
        [deleteButton setTitle:@"Done" forState:UIControlStateNormal];
    }
    else {
        [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    }
}

- (void)deleteButtonTapped:(id)deleteButtonTapped {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO];
    }
    else {
        [self.tableView setEditing:YES];
    }
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        return NO;
    }
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end