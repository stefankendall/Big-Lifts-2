#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+PurchaseOverlay.h"

@interface FTOPlanViewController : UITableViewController <UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet UITextField *trainingMaxField;

@property(weak, nonatomic) IBOutlet UITableViewCell *standardVariant;
@property(weak, nonatomic) IBOutlet UITableViewCell *pyramidVariant;
@property (weak, nonatomic) IBOutlet UITableViewCell *jokerVariant;
@property (weak, nonatomic) IBOutlet UITableViewCell *sixWeekVariant;
@property (weak, nonatomic) IBOutlet UITableViewCell *firstSetLastMultipleSetsVariant;

@end