#import "UIViewController+ViewDeckAdditions.h"
#import "UIViewController+PurchaseOverlay.h"
#import "BLTableViewController.h"

@interface FTOPlanViewController : BLTableViewController <UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet UITextField *trainingMaxField;
@property(weak, nonatomic) IBOutlet UISwitch *warmupToggle;
@property (weak, nonatomic) IBOutlet UISwitch *sixWeekToggle;

@property(weak, nonatomic) IBOutlet UITableViewCell *standardVariant;
@property(weak, nonatomic) IBOutlet UITableViewCell *heavierVariant;
@property (weak, nonatomic) IBOutlet UITableViewCell *powerliftingVariant;

@property(weak, nonatomic) IBOutlet UITableViewCell *pyramidVariant;
@property(weak, nonatomic) IBOutlet UITableViewCell *jokerVariant;
@property(weak, nonatomic) IBOutlet UITableViewCell *firstSetLastVariant;
@property(weak, nonatomic) IBOutlet UITableViewCell *firstSetLastMultipleSetsVariant;
@property(weak, nonatomic) IBOutlet UITableViewCell *advancedVariant;
@property(weak, nonatomic) IBOutlet UITableViewCell *fivesProgressionVariant;
@property(weak, nonatomic) IBOutlet UITableViewCell *customVariant;

- (IBAction)toggleSixWeek:(id)sender;

- (IBAction)toggleWarmup:(id)sender;
@end