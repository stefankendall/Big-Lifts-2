#import "FTOSSTViewController.h"
#import "FTOLiftStore.h"
#import "FTOLift.h"
#import "RowTextField.h"
#import "LiftFormCell.h"
#import "FTOEditLiftCell.h"
#import "TextFieldWithCell.h"
#import "FTOSSTLiftStore.h"
#import "FTOSSTLift.h"

@implementation FTOSSTViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FTOSSTLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOSSTLift *lift = ([[FTOSSTLiftStore instance] findAll])[(NSUInteger) indexPath.row];
    if ([indexPath section] == 0) {
        FTOEditLiftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOEditLiftCell.class)];
        if (cell == nil) {
            cell = [FTOEditLiftCell create];
        }

        [cell setLift:lift];
        [[cell max] setIndexPath:indexPath];
        [[cell max] setDelegate:self];
        return cell;
    }
    else {
        LiftFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LiftFormCell.class)];
        if (cell == nil) {
            cell = [LiftFormCell create];
        }
        [[cell liftLabel] setText:lift.name];
        [[cell textField] setText:[lift.increment stringValue]];
        return cell;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    RowTextField *rowTextField = (RowTextField *) textField;
    NSIndexPath *indexPath = [rowTextField indexPath];

    NSString *weightText = [textField text];

    if ([weightText isEqualToString:@""]) {
        [self.tableView reloadData];
        return;
    }

    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:weightText];
    FTOSSTLift *lift = [[FTOSSTLiftStore instance] atIndex:[indexPath row]];
    if ([indexPath section] == 0) {
        [lift setWeight:weight];
        [self.tableView reloadData];
    }
    else {
        [lift setIncrement:weight];
    }
}

@end