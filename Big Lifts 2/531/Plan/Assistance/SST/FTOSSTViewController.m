#import "FTOSSTViewController.h"
#import "RowTextField.h"
#import "FTOEditLiftCell.h"
#import "JFTOSSTLiftStore.h"
#import "JFTOSSTLift.h"
#import "FTOSSTEditLiftCell.h"

@implementation FTOSSTViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[JFTOSSTLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFTOSSTLift *lift = (JFTOSSTLift *) [self liftAtIndex:[indexPath row]];
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
        return [self incrementCell:tableView indexPath:indexPath];
    }
}

- (JLift *)liftAtIndex:(int)index {
    return [[JFTOSSTLiftStore instance] atIndex:index];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.bounds.size.height;
}

@end