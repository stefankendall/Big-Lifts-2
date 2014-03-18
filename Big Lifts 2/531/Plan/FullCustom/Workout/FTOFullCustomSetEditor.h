@class JSet;
@class PaddingTextField;

@interface FTOFullCustomSetEditor : UITableViewController <UITextFieldDelegate> {
}

@property(weak, nonatomic) IBOutlet PaddingTextField *reps;
@property(weak, nonatomic) IBOutlet PaddingTextField *percentage;
@property(weak, nonatomic) IBOutlet UISwitch *amrapSwitch;
@property(weak, nonatomic) IBOutlet UISwitch *warmupSwitch;

@property(nonatomic, strong) JSet *set;

- (void)valuesChanged:(id)valuesChanged;
@end