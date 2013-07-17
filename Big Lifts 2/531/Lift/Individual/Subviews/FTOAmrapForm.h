@class Set;

@interface FTOAmrapForm : UITableViewController
{}
@property (weak, nonatomic) IBOutlet UITextField *repsField;
@property (weak, nonatomic) IBOutlet UILabel *weightField;

- (void) setSet: (Set *) set;

@end