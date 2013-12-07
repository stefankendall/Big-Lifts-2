#import "UIViewController+ViewDeckAdditions.h"

@interface SettingsViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>

- (IBAction)unitsChanged:(id)sender;

- (IBAction)keepScreenOnChanged:(id)sender;

@property(weak, nonatomic) IBOutlet UITextField *roundToField;
@property (weak, nonatomic) IBOutlet UISwitch *keepScreenOnSwitch;
@property(strong, nonatomic) UIPickerView *roundToPicker;

@property(nonatomic, strong) NSArray *roundingText;
@end