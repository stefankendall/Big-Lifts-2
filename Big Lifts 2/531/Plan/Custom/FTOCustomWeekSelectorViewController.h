#import "BLTableViewController.h"

@interface FTOCustomWeekSelectorViewController : BLTableViewController <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editWeekButton;

- (void)copyTemplate;

- (IBAction)editWeekTapped:(id)sender;
@end