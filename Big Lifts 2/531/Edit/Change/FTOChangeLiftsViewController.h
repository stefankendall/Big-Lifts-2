#import "BLTableViewController.h"

@interface FTOChangeLiftsViewController : BLTableViewController <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *arrangeButton;

- (IBAction)arrangeButtonTapped:(id)sender;
@end