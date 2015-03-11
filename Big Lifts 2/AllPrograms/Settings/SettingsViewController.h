#import "UIViewController+ViewDeckAdditions.h"
#import "BLTableViewController.h"

@class PaddingTextField;

@interface SettingsViewController : BLTableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate, UITextFieldDelegate>

- (void)reloadData;

- (IBAction)unitsChanged:(id)sender;

- (IBAction)keepScreenOnChanged:(id)sender;

@property(weak, nonatomic) IBOutlet PaddingTextField *barWeightField;
@property(weak, nonatomic) IBOutlet UISwitch *barLoadingEnabledSwitch;
@property(weak, nonatomic) IBOutlet PaddingTextField *roundToField;
@property(weak, nonatomic) IBOutlet PaddingTextField *roundingTypeField;
@property(weak, nonatomic) IBOutlet UISwitch *keepScreenOnSwitch;

@property(strong, nonatomic) UIPickerView *roundToPicker;
@property(strong, nonatomic) UIPickerView *roundingTypePicker;

@property(nonatomic, strong) NSArray *roundingText;
@property(weak, nonatomic) IBOutlet UIView *barLoadingToggleCell;
@end