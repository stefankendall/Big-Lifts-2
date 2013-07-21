#import <MessageUI/MFMailComposeViewController.h>
@interface BLNavController : UITableViewController <MFMailComposeViewControllerDelegate>
- (void)presentFeedbackEmail;
@end