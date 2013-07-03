#import "UIViewController+ViewDeckAdditions.h"

@interface SettingsViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

- (IBAction)unitsChanged:(id)sender;

@property(weak, nonatomic) IBOutlet UITextField *roundToField;
@property(strong, nonatomic) UIPickerView *roundToPicker;

@end