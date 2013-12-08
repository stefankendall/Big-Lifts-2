#import "FTOSSTChangeLiftsViewController.h"
#import "JLift.h"
#import "JFTOSSTLiftStore.h"

@implementation FTOSSTChangeLiftsViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[JFTOSSTLiftStore instance] count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (JLift *)liftAtIndex:(int)index {
    return [[JFTOSSTLiftStore instance] atIndex:index];
}

@end