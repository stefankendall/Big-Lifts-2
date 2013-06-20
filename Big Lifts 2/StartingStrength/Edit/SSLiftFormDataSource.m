#import "SSLiftFormDataSource.h"
#import "BLStore.h"
#import "SSLiftStore.h"
#import "SSLift.h"
#import "TextFieldWithCell.h"
#import "TextFieldCell.h"
#import "SSLiftFormCell.h"

@implementation SSLiftFormDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[SSLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSLiftFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SSLiftFormCell.class)];
    if (cell == nil) {
        cell = [SSLiftFormCell create];
    }

    SSLift *lift = ([[SSLiftStore instance] findAll])[(NSUInteger) indexPath.row];
    [[cell liftLabel] setText:lift.name];

    [cell setIndexPath:indexPath];
    [[cell textField] setDelegate:self];
    [[cell textField] setInputAccessoryView:[self buildInputAccessoryView:[cell textField]]];
    if ([lift.weight doubleValue] > 0) {
        [[cell textField] setText:[lift.weight stringValue]];
    }

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [cell addGestureRecognizer:singleTap];

    return cell;
}

- (UIView *)buildInputAccessoryView:(UITextField *) textField {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:textField action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.items = @[barButton];

    textField.inputAccessoryView = toolbar;
    return toolbar;
}

- (void)cellTapped:(id)sender {
    UITapGestureRecognizer *recognizer = sender;
    SSLiftFormCell *cell = (SSLiftFormCell *) recognizer.view;
    [cell.textField becomeFirstResponder];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Lifts";
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *weight = [textField text];
    TextFieldWithCell *textViewWithCell = (TextFieldWithCell *) textField;
    NSInteger index = [[[textViewWithCell cell] indexPath] row];

    SSLift *lift = [[SSLiftStore instance] findAll][(NSUInteger) index];
    [lift setWeight:[NSNumber numberWithDouble:[weight doubleValue]]];
}


@end