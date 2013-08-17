@class FTOTriumvirate;
@class Set;

@interface FTOTriumvirateSetupViewController : UITableViewController {
}

@property(weak, nonatomic) IBOutlet UITextField *nameField;
@property(weak, nonatomic) IBOutlet UITextField *setsField;
@property(weak, nonatomic) IBOutlet UITextField *repsField;


- (void)setupForm:(FTOTriumvirate *)triumvirate forSet:(Set *)set;

@end