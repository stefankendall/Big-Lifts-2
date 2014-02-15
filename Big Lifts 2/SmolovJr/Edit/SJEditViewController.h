#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"
#import "BLTableViewController.h"

@interface SJEditViewController : BLTableViewController <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet UITextField *liftField;

@property (weak, nonatomic) IBOutlet UITextField *maxField;

@end