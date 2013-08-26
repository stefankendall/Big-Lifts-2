@class FTOTriumvirate;
@class Set;

@interface FTOTriumvirateSetupViewController : UITableViewController <UITextFieldDelegate> {
}

@property(weak, nonatomic) IBOutlet UITextField *nameField;
@property(weak, nonatomic) IBOutlet UITextField *setsField;
@property(weak, nonatomic) IBOutlet UITextField *repsField;


- (void)setupForm:(FTOTriumvirate *)triumvirate forSet:(Set *)set;

- (void)removeSets:(int)count;

- (void)addSets:(int)i;
@end