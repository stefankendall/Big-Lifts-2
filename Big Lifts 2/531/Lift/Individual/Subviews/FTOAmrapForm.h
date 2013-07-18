@class Set;
@protocol AmrapDelegate;

@interface FTOAmrapForm : UITableViewController <UITextFieldDelegate> {
}
@property(weak, nonatomic) IBOutlet UITextField *repsField;
@property(weak, nonatomic) IBOutlet UILabel *weightField;
@property(nonatomic, strong) NSObject <AmrapDelegate> *delegate;

@property(nonatomic, strong) Set*set;

- (void)setupFields;
@end