#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@class Lift;

@interface FTOEditViewController : UITableViewController <UITextFieldDelegate>

- (UITableViewCell *)liftFormCellFor:(UITableView *)tableView lift:(Lift *)lift;
@end