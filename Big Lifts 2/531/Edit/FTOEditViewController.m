#import "FTOEditViewController.h"
#import "FTOLiftStore.h"
#import "FTOLift.h"
#import "LiftFormCell.h"
#import "FTOEditLiftCell.h"
#import "RowTextField.h"
#import "TextViewInputAccessoryBuilder.h"
#import "TrainingMaxRowTextField.h"
#import "FTOSettings.h"
#import "FTOSettingsStore.h"
#import "FTOEditIncrementCell.h"

@implementation FTOEditViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FTOLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOLift *lift = (FTOLift *) [self liftAtIndex:[indexPath row]];
    if ([indexPath section] == 0) {
        FTOEditLiftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOEditLiftCell.class)];
        if (cell == nil) {
            cell = [FTOEditLiftCell create];
        }

        [cell setLift:lift];
        [[cell max] setIndexPath:indexPath];
        [[cell trainingMax] setIndexPath:indexPath];
        [[cell max] setDelegate:self];
        [[cell trainingMax] setDelegate:self];
        return cell;
    }
    else {
        return [self incrementCell:self.tableView indexPath:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 1 ? @"Increment" : @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"FTOEditMaxesHeader" owner:self options:nil][0];
        CGRect bounds = [view bounds];
        [view setBounds:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width,
                [self tableView:nil heightForHeaderInSection:section])];
        return view;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 33;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    RowTextField *rowTextField = (RowTextField *) textField;
    NSIndexPath *indexPath = [rowTextField indexPath];
    NSString *weightText = [textField text];
    Lift *lift = [self liftAtIndex:[indexPath row]];
    if ([weightText isEqualToString:@""]) {
        weightText = @"0";
    }
    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:weightText locale:NSLocale.currentLocale];

    if ([indexPath section] == 1) {
        [lift setIncrement:weight];
    }
    else {
        if ([textField isKindOfClass:TrainingMaxRowTextField.class]) {
            FTOSettings *ftoSettings = [[FTOSettingsStore instance] first];
            NSDecimalNumber *max =
                    [[N(100) decimalNumberByDividingBy:[ftoSettings trainingMax]] decimalNumberByMultiplyingBy:weight];
            NSNumberFormatter *nf = [NSNumberFormatter new];
            [nf setMaximumFractionDigits:1];
            NSString *oneDecimalMax = [nf stringFromNumber:max];
            [lift setWeight:[NSDecimalNumber decimalNumberWithString:oneDecimalMax locale:NSLocale.currentLocale]];
        }
        else {
            [lift setWeight:weight];
        }
        [self.tableView reloadData];
    }
}

- (UITableViewCell *)incrementCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    Lift *lift = [self liftAtIndex:[indexPath row]];
    FTOEditIncrementCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOEditIncrementCell.class)];
    if (cell == nil) {
        cell = [FTOEditIncrementCell create];
    }
    [[cell liftLabel] setText:lift.name];
    [[cell increment] setText:[lift.increment stringValue]];
    [[cell increment] setDelegate:self];
    [cell increment].indexPath = indexPath;
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:[cell increment]];
    return cell;
}

- (Lift *)liftAtIndex:(int)index {
    return [[FTOLiftStore instance] atIndex:index];
}

@end