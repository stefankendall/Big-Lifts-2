#import "UIViewController+ViewDeckAdditions.h"

@interface FTOPlanViewController : UITableViewController <UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet UITextField *trainingMaxField;

@property(weak, nonatomic) IBOutlet UITableViewCell *standardVariant;
@property(weak, nonatomic) IBOutlet UITableViewCell *pyramidVariant;

@end