#import <MessageUI/MFMailComposeViewController.h>
#import "BLTableViewController.h"

@interface TestSaveViewController : BLTableViewController <MFMailComposeViewControllerDelegate> {
}
@property(weak, nonatomic) IBOutlet UIButton *startButton;
@property(weak, nonatomic) IBOutlet UIButton *emailButton;
@property(weak, nonatomic) IBOutlet UILabel *statusLabel;

- (NSString *)naiveSerializeAllData;
@end