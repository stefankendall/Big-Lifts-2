#import "SVEditViewController.h"
#import "JSVLiftStore.h"
#import "LiftFormCell.h"
#import "JSVLift.h"
#import "PaddingRowTextField.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation SVEditViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [[JSVLiftStore instance] count] - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiftFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LiftFormCell.class)];
    if (!cell) {
        cell = [LiftFormCell create];
    }

    JSVLift *lift = nil;
    if (indexPath.section == 0) {
        lift = [[JSVLiftStore instance] atIndex:0];
    }
    else {
        lift = [[JSVLiftStore instance] atIndex:indexPath.row + 1];
    }
    NSLog(@"%@", lift);
    [cell.liftLabel setText:lift.name];
    [cell.textField setText:[NSString stringWithFormat:@"%@", lift.weight]];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:cell.textField];
    [cell.textField setDelegate:self];
    [cell.textField setIndexPath:indexPath];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Max";
    }
    else {
        return @"Weight";
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    PaddingRowTextField *rowTextField = (PaddingRowTextField *) textField;
    NSIndexPath *indexPath = rowTextField.indexPath;
    JSVLift *svLift = nil;
    if (indexPath.section == 0) {
        svLift = [[JSVLiftStore instance] atIndex:0];
    }
    else {
        svLift = [[JSVLiftStore instance] atIndex:1 + indexPath.row];
    }
    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:[textField text] locale:[NSLocale currentLocale]];
    svLift.weight = weight;

    NSLog(@"%@", svLift);
}

@end