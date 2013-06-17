#import "BarLoadingDataSource.h"
#import "PlateStore.h"
#import "WeightTableCell.h"
#import "Plate.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "StepperWithCell.h"
#import "BarWeightCell.h"
#import "BarWeightTextFieldDelegate.h"
#import "TextFieldWithCell.h"
#import "BarStore.h"
#import "Bar.h"
#import "RowUIButton.h"

@implementation BarLoadingDataSource
@synthesize tableView;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Bar";
    }
    else {
        return @"Plates";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        int ADD_ROW_COUNT = 1;
        return [[PlateStore instance] count] + ADD_ROW_COUNT;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        return [self getBarWeightCell:tableView];
    }
    else {
        return [self getPlateCell:tableView indexPath:indexPath];
    }
}

- (UITableViewCell *)getPlateCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    if (row == [[PlateStore instance] count]) {
        return [self getAddCell:tableView];
    }
    else {
        WeightTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeightTableCell"];

        if (cell == nil) {
            cell = [WeightTableCell create];
        }

        Plate *plate = [[PlateStore instance] atIndex:row];
        Settings *settings = [[SettingsStore instance] first];
        [cell.weightLabel setText:[NSString stringWithFormat:@"%.1f", [plate.weight doubleValue]]];
        [cell.unitsLabel setText:settings.units];
        [cell.countLabel setText:[plate.count stringValue]];
        cell.indexPath = indexPath;

        [cell.stepper addTarget:self action:@selector(plateCountChanged:) forControlEvents:UIControlEventValueChanged];
        cell.deleteButton.indexPath = indexPath;
        [cell.deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

        [self modifyCellForPlateCount:cell currentPlateCount:[plate.count intValue]];

        return cell;
    }
}

- (void)deleteButtonTapped:(id)deleteButton {
    RowUIButton *button = deleteButton;
    int row = [[button indexPath] row];
    [[PlateStore instance] removeAtIndex:row];
    [tableView reloadData];
}

- (UITableViewCell *)getAddCell:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeightTableAddCell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WeightTableAddCell"];
    }

    [[cell textLabel] setText:@"Add..."];
    [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
    [[cell textLabel] setTextColor:[UIColor darkTextColor]];

    return cell;
}

- (UITableViewCell *)getBarWeightCell:(UITableView *)tableView {
    BarWeightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BarWeightCell"];

    if (cell == nil ) {
        cell = [BarWeightCell create];
    }

    Bar *bar = [[BarStore instance] first];
    [[cell textField] setText:[NSString stringWithFormat:@"%.1f", [bar.weight doubleValue]]];
    barWeightTextFieldDelegate = [BarWeightTextFieldDelegate new];
    [[cell textField] setDelegate:barWeightTextFieldDelegate];
    barWeightTextField = [cell textField];

    return cell;
}


- (void)plateCountChanged:(UIStepper *)plateStepper {
    StepperWithCell *stepperWithCell = (StepperWithCell *) plateStepper;

    int row = [[[stepperWithCell cell] indexPath] row];
    Plate *p = [[PlateStore instance] atIndex:row];

    int additiveCount = (int) [stepperWithCell value];
    int currentPlateCount = [p.count intValue];

    if (additiveCount + currentPlateCount < 0) {
        currentPlateCount = 0;
    }
    else {
        currentPlateCount += additiveCount;
    }

    p.count = [NSNumber numberWithInt:currentPlateCount];

    [self modifyCellForPlateCount:[stepperWithCell cell] currentPlateCount:currentPlateCount];
    [tableView reloadData];
}

- (void)modifyCellForPlateCount:(WeightTableCell *)cell currentPlateCount:(int)currentPlateCount {
    UIStepper *plateStepper = [cell stepper];
    [plateStepper setValue:0];

    BOOL atMinimum = currentPlateCount == 0;
    [plateStepper setMinimumValue:(atMinimum ? 0 : -2)];
    [[cell platesLabel] setHidden:atMinimum];
    [[cell countLabel] setHidden:atMinimum];
    [[cell deleteButton] setHidden:!atMinimum];
}


- (BOOL)isEditing {
    return [barWeightTextField isEditing];
}

@end