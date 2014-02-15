#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"
#import "BLTableViewController.h"

@interface FTOEditViewController : BLTableViewController <UITextFieldDelegate>

- (UITableViewCell *)incrementCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end