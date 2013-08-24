#import "FTOSSTChangeLiftsViewController.h"
#import "Lift.h"
#import "FTOSSTLiftStore.h"

@implementation FTOSSTChangeLiftsViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FTOSSTLiftStore instance] count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (Lift *)liftAtIndex:(int)index {
    return [[FTOSSTLiftStore instance] atIndex:index];
}

@end