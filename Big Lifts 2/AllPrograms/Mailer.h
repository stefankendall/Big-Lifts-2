#import <MessageUI/MFMailComposeViewController.h>
@interface Mailer : NSObject
- (void)presentFeedback;

@property(nonatomic, strong) UIViewController <MFMailComposeViewControllerDelegate> *sender;

- (id)initWithSender:(UIViewController <MFMailComposeViewControllerDelegate> *)sender;

+ (id)mailerWithSender:(UIViewController <MFMailComposeViewControllerDelegate> *)sender;

@end