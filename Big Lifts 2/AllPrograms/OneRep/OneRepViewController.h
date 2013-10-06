#import "UIViewController+ViewDeckAdditions.h"

@interface OneRepViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
}
@property(weak, nonatomic) IBOutlet UITextField *weightField;
@property(weak, nonatomic) IBOutlet UITextField *repsField;
@property(weak, nonatomic) IBOutlet UILabel *maxLabel;
@property(weak, nonatomic) IBOutlet UITextField *formulaSelector;
@property(weak, nonatomic) IBOutlet UILabel *formulaDescription;
@property (weak, nonatomic) IBOutlet UITableViewCell *marketingTextCell;
@property(nonatomic, strong) UIPickerView *formulaPicker;
@end