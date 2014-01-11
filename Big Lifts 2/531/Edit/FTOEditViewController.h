#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@interface FTOEditViewController : UITableViewController <UITextFieldDelegate>

- (UITableViewCell *)incrementCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end