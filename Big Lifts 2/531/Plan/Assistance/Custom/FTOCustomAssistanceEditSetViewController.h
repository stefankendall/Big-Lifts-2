@class JSet;
@class PaddingTextField;

@interface FTOCustomAssistanceEditSetViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
}
@property(weak, nonatomic) IBOutlet UIButton *addLiftButton;

@property(weak, nonatomic) IBOutlet PaddingTextField *liftTextField;
@property(weak, nonatomic) IBOutlet PaddingTextField *percentageTextField;
@property(weak, nonatomic) IBOutlet PaddingTextField *repsTextField;

@property(nonatomic, strong) JSet *set;

@property(nonatomic, strong) UIPickerView *liftsPicker;
@end