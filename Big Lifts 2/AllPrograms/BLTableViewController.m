#import "BLTableViewController.h"
#import "JSettings.h"
#import "FTOWorkoutCell.h"

@interface BLTableViewController ()
@end

@implementation BLTableViewController

- (void)registerCellNib:(Class)klass {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(klass) bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:NSStringFromClass(klass)];
}

@end