#import "UIViewController+ViewDeckAdditions.h"
#import "UIViewController+PurchaseOverlay.h"

@interface FTOPlanViewController : UITableViewController <UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet UITextField *trainingMaxField;
@property (weak, nonatomic) IBOutlet UISwitch *warmupToggle;

@property(weak, nonatomic) IBOutlet UITableViewCell *standardVariant;
@property(weak, nonatomic) IBOutlet UITableViewCell *pyramidVariant;
@property (weak, nonatomic) IBOutlet UITableViewCell *jokerVariant;
@property (weak, nonatomic) IBOutlet UITableViewCell *sixWeekVariant;
@property (weak, nonatomic) IBOutlet UITableViewCell *firstSetLastMultipleSetsVariant;
@property (weak, nonatomic) IBOutlet UITableViewCell *advancedVariant;
@property (weak, nonatomic) IBOutlet UITableViewCell *fivesProgressionVariant;
@property (weak, nonatomic) IBOutlet UITableViewCell *customVariant;

- (IBAction)toggleWarmup:(id)sender;
@end