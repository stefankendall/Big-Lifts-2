#import <FlurrySDK/Flurry.h>
#import "FTOChangeLiftsViewController.h"
#import "JFTOLiftStore.h"
#import "FTOChangeLiftCell.h"
#import "RowTextField.h"
#import "UITableViewController+NoEmptyRows.h"
#import "JFTOWorkoutStore.h"
#import "AddCell.h"
#import "JFTOLift.h"

@implementation FTOChangeLiftsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNib:FTOChangeLiftCell.class];
    [self registerCellNib:AddCell.class];
}


- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"5/3/1_ChangeLifts"];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([tableView isEditing]) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [[JFTOLiftStore instance] count];
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        FTOChangeLiftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOChangeLiftCell.class)];

        JLift *lift = [self liftAtIndex:[indexPath row]];
        [cell.textField setText:lift.name];
        [cell.textField setDelegate:self];
        [cell.textField setIndexPath:indexPath];
        return cell;
    }
    else {
        AddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCell.class)];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[JFTOLiftStore instance] removeAtIndex:[indexPath row]];
        [self.tableView reloadData];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    RowTextField *rowTextField = (RowTextField *) textField;
    JLift *lift = [self liftAtIndex:[rowTextField.indexPath row]];
    if (lift) {
        [lift setName:[textField text]];
    }
}

- (JLift *)liftAtIndex:(int)index {
    return [[JFTOLiftStore instance] atIndex:index];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1) {
        [self performSegueWithIdentifier:@"ftoAddLiftSegue" sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (IBAction)arrangeButtonTapped:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO];
        [self.arrangeButton setTitle:@"Edit"];
    }
    else {
        [self.tableView setEditing:YES];
        [self.arrangeButton setTitle:@"Done"];
    }

    [self.tableView reloadData];
}

- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath {
    int sourceRow = [sourceIndexPath row];
    int destRow = [destinationIndexPath row];
    if (sourceRow == destRow) {
        return;
    }

    JFTOLift *source = [[JFTOLiftStore instance] atIndex:sourceRow];
    JFTOLift *dest = [[JFTOLiftStore instance] atIndex:destRow];

    if ([dest.order doubleValue] < [source.order doubleValue]) {
        source.order = [NSNumber numberWithDouble:[dest.order doubleValue] - 0.5];
    } else {
        source.order = [NSNumber numberWithDouble:[dest.order doubleValue] + 0.5];
    }

    [self restitchLiftOrder];
}

- (void)restitchLiftOrder {
    NSArray *lifts = [[JFTOLiftStore instance] findAll];
    for (int i = 0; i < [lifts count]; i++) {
        JLift *lift = lifts[(NSUInteger) i];
        [lift setOrder:[NSNumber numberWithInt:i]];
    }
    [[JFTOWorkoutStore instance] reorderWorkoutsToLifts];
}

@end