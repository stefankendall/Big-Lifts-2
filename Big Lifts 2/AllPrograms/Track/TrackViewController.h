#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@interface TrackViewController : UITableViewController
- (int)getRowCount:(NSIndexPath *)path;

- (void)setupDeleteButton:(UIButton *)deleteButton;
@end