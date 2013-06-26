#import "SSLiftFormDataSource.h"
#import "BLStore.h"
#import "SSLiftStore.h"
#import "SSLift.h"
#import "TextFieldWithCell.h"
#import "TextFieldCell.h"
#import "LiftFormCell.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation SSLiftFormDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[SSLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiftFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LiftFormCell.class)];
    if (cell == nil) {
        cell = [LiftFormCell create];
    }

    SSLift *lift = ([[SSLiftStore instance] findAll])[(NSUInteger) indexPath.row];
    [[cell liftLabel] setText:lift.name];

    [cell setIndexPath:indexPath];
    [[cell textField] setDelegate:self];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:[cell textField]];

    if ([indexPath section] == 0) {
        if ([lift.weight doubleValue] > 0) {
            [[cell textField] setText:[lift.weight stringValue]];
        }
    }
    else {
        [[cell textField] setText:[lift.increment stringValue]];
    }

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [cell addGestureRecognizer:singleTap];

    return cell;
}

- (void)cellTapped:(id)sender {
    UITapGestureRecognizer *recognizer = sender;
    LiftFormCell *cell = (LiftFormCell *) recognizer.view;
    [cell.textField becomeFirstResponder];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"Lifts - current weight" : @"Increment";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    TextFieldWithCell *textViewWithCell = (TextFieldWithCell *) textField;
    NSIndexPath *indexPath = [[textViewWithCell cell] indexPath];

    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:[textField text]];
    SSLift *lift = [[SSLiftStore instance] findAll][(NSUInteger) [indexPath row]];
    if ([indexPath section] == 0) {
        [lift setWeight:weight];
    }
    else {
        [lift setIncrement:weight];
    }
}


@end