#import "BLTableViewController.h"

@class JFTOTriumvirate;
@class JSet;

@interface FTOTriumvirateSetupViewController : BLTableViewController <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UITextField *nameField;
@property(weak, nonatomic) IBOutlet UITextField *setsField;
@property(weak, nonatomic) IBOutlet UITextField *repsField;

- (void)setupForm:(JFTOTriumvirate *)triumvirate forSet:(JSet *)set;

- (void)removeSets:(int)count;

- (void)addSets:(int)i;
@end