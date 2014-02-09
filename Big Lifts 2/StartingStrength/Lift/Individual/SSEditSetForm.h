@class JSet;
@class PaddingTextField;
@protocol SetChangeDelegate;

@interface SSEditSetForm : UITableViewController <UITextFieldDelegate>
@property(weak, nonatomic) IBOutlet PaddingTextField *weightField;
@property(weak, nonatomic) IBOutlet PaddingTextField *repsField;

@property(nonatomic, strong) JSet *set;
@property(nonatomic, strong) NSObject <SetChangeDelegate> *delegate;
@end