#import "UIViewController+ViewDeckAdditions.h"

@interface FTOPlanViewController : UITableViewController <UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet UITextField *trainingMaxField;

@property(weak, nonatomic) IBOutlet UITableViewCell *standardVariant;
@property(weak, nonatomic) IBOutlet UITableViewCell *pyramidVariant;
@property (weak, nonatomic) IBOutlet UITableViewCell *jokerVariant;

@end