#import "BLTableViewController.h"

@class JSet;
@class PaddingTextField;

@interface FTORepsToBeatBreakdown : BLTableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet UILabel *enteredOneRepMax;
@property(weak, nonatomic) IBOutlet UILabel *maxFromLog;
@property(weak, nonatomic) IBOutlet UILabel *reps;
@property(weak, nonatomic) IBOutlet UILabel *weight;
@property(weak, nonatomic) IBOutlet UILabel *estimatedMax;
@property (weak, nonatomic) IBOutlet PaddingTextField *configTextField;

@property(nonatomic, strong) JSet *lastSet;
@property(nonatomic, strong) UIPickerView *configPicker;
@property(nonatomic, strong) NSDictionary *configOptions;
@end