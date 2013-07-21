@class Set;
@protocol SetRepsDelegate;

@interface FTOSetRepsForm : UITableViewController <UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet UITextField *repsField;
@property(weak, nonatomic) IBOutlet UILabel *weightField;
@property(nonatomic, strong) NSObject <SetRepsDelegate> *delegate;

@property(nonatomic, strong) Set *set;

- (void)setupFields;
@end