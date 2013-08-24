#import "FTOSSTViewController.h"
#import "FTOLiftStore.h"
#import "FTOLift.h"
#import "RowTextField.h"
#import "LiftFormCell.h"
#import "FTOEditLiftCell.h"
#import "FTOSSTLiftStore.h"
#import "FTOSSTLift.h"
#import "FTOSSTEditLiftCell.h"

@implementation FTOSSTViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FTOSSTLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOSSTLift *lift = (FTOSSTLift *) [self liftAtIndex:[indexPath row]];
    if ([indexPath section] == 0) {
        FTOSSTEditLiftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOSSTEditLiftCell.class)];
        if (cell == nil) {
            cell = [FTOSSTEditLiftCell create];
        }

        [cell setLift:lift];
        [[cell max] setIndexPath:indexPath];
        [[cell max] setDelegate:self];
        return cell;
    }
    else {
        return [self liftFormCellFor:tableView lift:lift];
    }
}

- (Lift *)liftAtIndex:(int)index {
    return [[FTOSSTLiftStore instance] atIndex:index];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.bounds.size.height;
}


@end