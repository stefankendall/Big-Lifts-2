#import "FTOBoringButBigEditViewController.h"
#import "JFTOLiftStore.h"
#import "FTOBoringButBigEditCell.h"
#import "JFTOLift.h"
#import "PaddingTextField.h"
#import "PaddingRowTextField.h"

@implementation FTOBoringButBigEditViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[JFTOLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOBoringButBigEditCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOBoringButBigEditCell.class)];
    if (!cell) {
        cell = [FTOBoringButBigEditCell create];
    }

    JFTOLift *ftoLift = [[JFTOLiftStore instance] atIndex:indexPath.row];
    [[cell forLift] setText:ftoLift.name];
    [[cell useLift] setText:ftoLift.name];
    [[cell useLift] setDelegate:self];
    [[cell useLift] setIndexPath:indexPath];

    [cell.liftPicker selectRow:indexPath.row inComponent:0 animated:NO];

    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    PaddingRowTextField *rowTextField = (PaddingRowTextField *) textField;
    NSLog(@"%i", rowTextField.indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

@end