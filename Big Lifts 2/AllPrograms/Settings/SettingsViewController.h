#import "UIViewController+ViewDeckAdditions.h"

@interface SettingsViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>

- (IBAction)unitsChanged:(id)sender;

@property(weak, nonatomic) IBOutlet UITextField *roundToField;
@property(strong, nonatomic) UIPickerView *roundToPicker;

@property(nonatomic, strong) NSArray *roundingText;
@end