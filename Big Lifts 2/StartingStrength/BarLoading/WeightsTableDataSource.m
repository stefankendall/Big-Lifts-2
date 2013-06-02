#import "WeightsTableDataSource.h"
#import "PlateStore.h"
#import "WeightTableCell.h"
#import "Plate.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation WeightsTableDataSource
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

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}

@end