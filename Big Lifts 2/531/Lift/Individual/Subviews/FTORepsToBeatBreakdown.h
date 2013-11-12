@class Set;
@class PaddingTextField;

@interface FTORepsToBeatBreakdown : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet UILabel *enteredOneRepMax;
@property(weak, nonatomic) IBOutlet UILabel *maxFromLog;
@property(weak, nonatomic) IBOutlet UILabel *reps;
@property(weak, nonatomic) IBOutlet UILabel *weight;
@property(weak, nonatomic) IBOutlet UILabel *estimatedMax;
@property (weak, nonatomic) IBOutlet PaddingTextField *configTextField;

@property(nonatomic, strong) Set *lastSet;
@property(nonatomic, strong) UIPickerView *configPicker;
@property(nonatomic, strong) NSDictionary *configOptions;
@end