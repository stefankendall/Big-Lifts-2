@class JSet;
@class PaddingTextField;

@interface FTOFullCustomSetEditor : UITableViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
}

@property (weak, nonatomic) IBOutlet PaddingTextField *lift;
@property(weak, nonatomic) IBOutlet PaddingTextField *reps;
@property(weak, nonatomic) IBOutlet PaddingTextField *percentage;
@property(weak, nonatomic) IBOutlet UISwitch *amrapSwitch;
@property(weak, nonatomic) IBOutlet UISwitch *warmupSwitch;

@property(nonatomic, strong) JSet *set;

@property(nonatomic, strong) UIPickerView *liftsPicker;

- (void)valuesChanged:(id)valuesChanged;
@end