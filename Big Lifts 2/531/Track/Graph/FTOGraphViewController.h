
@interface FTOGraphViewController : UIViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate> {}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *exportButton;

@end