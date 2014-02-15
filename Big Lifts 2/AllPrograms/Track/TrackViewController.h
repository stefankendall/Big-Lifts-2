#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"
#import "BLTableViewController.h"

@interface TrackViewController : BLTableViewController
- (int)getRowCount:(NSIndexPath *)path;

- (void)setupDeleteButton:(UIButton *)deleteButton;
@end