#import <MessageUI/MFMailComposeViewController.h>
#import "BLTableViewController.h"

@class NavTableViewCell;

@interface BLNavController : BLTableViewController <MFMailComposeViewControllerDelegate>
@property(weak, nonatomic) IBOutlet UILabel *unlockEverythingLabel;
@property(weak, nonatomic) IBOutlet NavTableViewCell *unlockEverythingCell;

- (void)presentFeedbackEmail;
@end