#import "BLTableViewController.h"

@interface FTOBoringButBigViewController : BLTableViewController
@property (weak, nonatomic) IBOutlet UITextField *percentageField;
@property (weak, nonatomic) IBOutlet UISwitch *threeMonthToggle;

- (IBAction)percentageChanged:(id)sender;

- (IBAction)toggleThreeMonthChallenge:(id)sender;
@end