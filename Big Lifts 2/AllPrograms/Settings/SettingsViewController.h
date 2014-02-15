#import "UIViewController+ViewDeckAdditions.h"
#import "BLTableViewController.h"

@interface SettingsViewController : BLTableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>

- (IBAction)unitsChanged:(id)sender;

- (IBAction)keepScreenOnChanged:(id)sender;

@property(weak, nonatomic) IBOutlet UITextField *roundToField;
@property (weak, nonatomic) IBOutlet UISwitch *keepScreenOnSwitch;
@property(strong, nonatomic) UIPickerView *roundToPicker;
@property (weak, nonatomic) IBOutlet UITableViewCell *testDataSavingCell;
@property (weak, nonatomic) IBOutlet UISwitch *iCloudEnabled;

@property(nonatomic, strong) NSArray *roundingText;
@end