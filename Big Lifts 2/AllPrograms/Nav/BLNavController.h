#import <MessageUI/MFMailComposeViewController.h>

@class NavTableViewCell;

@interface BLNavController : UITableViewController <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *unlockEverythingLabel;
@property (weak, nonatomic) IBOutlet NavTableViewCell *unlockEverythingCell;
- (void)presentFeedbackEmail;
@end