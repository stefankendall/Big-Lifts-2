#import <MessageUI/MessageUI.h>
#import "Mailer.h"

@implementation Mailer

- (id)initWithSender:(UIViewController <MFMailComposeViewControllerDelegate> *)sender {
    self = [super init];
    if (self) {
        self.sender = sender;
    }

    return self;
}

+ (id)mailerWithSender:(UIViewController <MFMailComposeViewControllerDelegate> *)sender {
    return [[self alloc] initWithSender:sender];
}

- (void)presentFeedback {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *emailController = [[MFMailComposeViewController alloc] init];
        emailController.mailComposeDelegate = self.sender;
        [emailController setSubject:@"Big Lifts 2 Feedback"];
        [emailController setToRecipients:@[@"biglifts@stefankendall.com"]];
        [self.sender presentViewController:emailController animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Can't open email" message:@"No mail account configured" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

@end