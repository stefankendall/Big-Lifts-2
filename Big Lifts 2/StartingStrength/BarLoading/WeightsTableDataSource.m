#import "WeightsTableDataSource.h"
#import "PlateStore.h"
#import "WeightTableCell.h"
#import "Plate.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "StepperWithCell.h"

@implementation WeightsTableDataSource
@synthesize onDataChange;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[PlateStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeightTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SSLiftsCell"];

    if (cell == nil) {
        cell = [WeightTableCell createNewTextCellFromNib];
    }

    Plate *plate = [[PlateStore instance] atIndex:[indexPath row]];
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
    if (onDataChange) {
        onDataChange();
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}

@end