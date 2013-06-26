#import "LiftFormCellHelper.h"
#import "LiftFormCell.h"

@implementation LiftFormCellHelper

+ (NSArray *)getLiftNamesFromCells:(NSObject <UITableViewDataSource> *)dataSource count: (int) count {
    NSMutableArray *lifts = [@[] mutableCopy];
    for (int i = 0; i < count; i++) {
        LiftFormCell *cell = (LiftFormCell *)
                [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [lifts addObject:cell.liftLabel.text];
    }
    return lifts;
}

@end