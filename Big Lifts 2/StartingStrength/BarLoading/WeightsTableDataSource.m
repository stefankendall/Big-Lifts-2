#import "WeightsTableDataSource.h"
#import "PlateStore.h"
#import "WeightTableCell.h"
#import "Plate.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "AddPlateTextFieldDelegate.h"
#import "StepperWithCell.h"
#import "BarWeightCell.h"
#import "BarWeightTextFieldDelegate.h"
#import "TextFieldWithCell.h"
#import "BarStore.h"
#import "Bar.h"
#import "AddPlateCell.h"

@implementation WeightsTableDataSource
@synthesize tableView;

- (id)init {
    self = [super init];
    if (self) {
        addingPlate = NO;
    }

    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Bar";
    }
    else {
        return @"Plates";
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
            cell = [WeightTableCell createNewTextCellFromNib];
        }

        Plate *plate = [[PlateStore instance] atIndex:row];
        Settings *settings = [[SettingsStore instance] first];
        [cell.weightLabel setText:[NSString stringWithFormat:@"%.1f", [plate.weight doubleValue]]];
        [cell.unitsLabel setText:settings.units];
        [cell.countLabel setText:[plate.count stringValue]];
        cell.indexPath = indexPath;

        [cell.stepper addTarget:self action:@selector(plateCountChanged:) forControlEvents:UIControlEventValueChanged];
        if ([plate.count intValue] == 0) {
            [cell.stepper setMinimumValue:0];
        }

        return cell;
    }
}

- (UITableViewCell *)getAddCell:(UITableView *)tableView {
    if (!addingPlate) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeightTableAddCell"];

        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WeightTableAddCell"];
        }

        [[cell textLabel] setText:@"Add..."];
        [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
        [[cell textLabel] setTextColor:[UIColor darkTextColor]];

        return cell;
    }

    else {
        AddPlateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddPlateCell"];

        if (cell == nil) {
            cell = [AddPlateCell createNewTextCellFromNib];
        }

        addPlateTextFieldDelegate = [AddPlateTextFieldDelegate new];
        [[cell weightField] setDelegate:addPlateTextFieldDelegate];
        addPlateTextField = [cell weightField];

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == [[PlateStore instance] count]) {
        addingPlate = YES;
        [tableView reloadData];
    }
}

- (UITableViewCell *)getBarWeightCell:(UITableView *)tableView {
    BarWeightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BarWeightCell"];

    if (cell == nil ) {
        cell = [BarWeightCell createNewTextCellFromNib];
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

    [plateStepper setValue:0];
    p.count = [NSNumber numberWithInt:currentPlateCount];
    [tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}

- (BOOL)isEditing {
    return [barWeightTextField isEditing] || [addPlateTextField isEditing];
}

@end