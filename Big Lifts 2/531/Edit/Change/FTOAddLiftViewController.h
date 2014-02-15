#import "BLTableViewController.h"

@interface FTOAddLiftViewController : BLTableViewController <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UITextField *increaseField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

- (BOOL)allFieldsAreFilled;

- (IBAction)doneButtonTapped:(id)sender;
@end