#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@interface SJEditViewController : UITableViewController <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet UITextField *liftField;

@property (weak, nonatomic) IBOutlet UITextField *maxField;

@end