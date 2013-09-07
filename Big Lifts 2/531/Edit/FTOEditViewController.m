#import "FTOEditViewController.h"
#import "FTOLiftStore.h"
#import "FTOLift.h"
#import "LiftFormCell.h"
#import "FTOEditLiftCell.h"
#import "RowTextField.h"
#import "TextFieldWithCell.h"
#import "TextViewInputAccessoryBuilder.h"
#import "TrainingMaxRowTextField.h"
#import "FTOSettings.h"
#import "FTOSettingsStore.h"

@implementation FTOEditViewController

- (void)viewDidLoad {
    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)handleSingleTap:(id)handleSingleTap {
    [self.view endEditing:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FTOLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOLift *lift = ([[FTOLiftStore instance] findAll])[(NSUInteger) indexPath.row];
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
        return [self liftFormCellFor:self.tableView lift:lift];
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
    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:weightText];

    if ([indexPath section] == 1) {
        [lift setIncrement:weight];
    }
    else {
        if ([textField isKindOfClass:TrainingMaxRowTextField.class]) {
            NSDecimalNumber *trainingMax = [[[FTOSettingsStore instance] first] trainingMax];
            NSDecimalNumber *max =
                    [[N(100) decimalNumberByDividingBy:trainingMax] decimalNumberByMultiplyingBy:weight];
            NSNumberFormatter *nf = [NSNumberFormatter new];
            [nf setMaximumFractionDigits:1];
            NSString *oneDecimalMax = [nf stringFromNumber:max];
            [lift setWeight:[NSDecimalNumber decimalNumberWithString:oneDecimalMax]];
        }
        else {
            [lift setWeight:weight];
        }
        [self.tableView reloadData];
    }
}

- (UITableViewCell *)liftFormCellFor:(UITableView *)tableView lift:(Lift *)lift {
    LiftFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LiftFormCell.class)];
    if (cell == nil) {
        cell = [LiftFormCell create];
    }
    [[cell liftLabel] setText:lift.name];
    [[cell textField] setText:[lift.increment stringValue]];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:[cell textField]];
    return cell;
}

- (Lift *)liftAtIndex:(int)index {
    return [[FTOLiftStore instance] atIndex:index];
}

@end