@class JSet;
@class PaddingTextField;
@class JWorkout;

@interface FTOCustomAssistanceEditSetViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
}
@property(weak, nonatomic) IBOutlet UIButton *addLiftButton;

@property(weak, nonatomic) IBOutlet PaddingTextField *liftTextField;
@property(weak, nonatomic) IBOutlet PaddingTextField *percentageTextField;
@property(weak, nonatomic) IBOutlet PaddingTextField *repsTextField;
@property(weak, nonatomic) IBOutlet UISwitch *useBigLiftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *useTrainingMaxSwitch;

@property(nonatomic, strong) JSet *set;

@property(nonatomic, strong) UIPickerView *liftsPicker;
@property(nonatomic) BOOL usingBigLift;

@property(nonatomic, strong) JWorkout *workout;

- (void)updateSet;

- (IBAction)useTrainingMaxChanged:(id)sender;
@end