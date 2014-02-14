#import "UIViewController+ViewDeckAdditions.h"

@class PaddingTextField;

@interface OneRepViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
}
@property(weak, nonatomic) IBOutlet UITextField *weightField;
@property(weak, nonatomic) IBOutlet UITextField *repsField;
@property(weak, nonatomic) IBOutlet UILabel *maxLabel;
@property(weak, nonatomic) IBOutlet UITextField *formulaSelector;
@property(weak, nonatomic) IBOutlet UILabel *formulaDescription;
@property(nonatomic, strong) UIPickerView *formulaPicker;

@property (weak, nonatomic) IBOutlet UILabel *wilksCoefficient;
@property (weak, nonatomic) IBOutlet PaddingTextField *bodyweightField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *maleFemaleSegment;

- (IBAction)maleFemaleSegmentChanged:(id)sender;
- (IBAction)bodyweightChanged:(id)sender;

@end