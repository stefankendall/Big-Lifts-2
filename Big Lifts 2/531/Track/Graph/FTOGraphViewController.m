#import <MessageUI/MessageUI.h>
#import "FTOGraphViewController.h"
#import "WebViewJavascriptBridge.h"
#import "FTOLogGraphTransformer.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "UIViewController+PurchaseOverlay.h"
#import "PurchaseOverlay.h"
#import "FTOLogExporter.h"

@interface FTOGraphViewController ()

@property(nonatomic, strong) WebViewJavascriptBridge *bridge;
@end

@implementation FTOGraphViewController

- (void)viewDidLoad {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]
            pathForResource:@"graph" ofType:@"html"]                  isDirectory:NO]]];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:(WVJBHandler) ^{
    }];

    [self enableDisableIap];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enableDisableIap)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (IBAction)export:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *controller = [MFMailComposeViewController new];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"My Log"];
        [controller addAttachmentData:[[FTOLogExporter new] logData] mimeType:@"text/csv" fileName:@"log.csv"];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Can't open email" message:@"No mail account configured" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)enableDisableIap {
    if (![[IAPAdapter instance] hasPurchased:IAP_GRAPHING]) {
        [self disable:IAP_GRAPHING view:self.webView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOverlay:)];
        [[self.webView viewWithTag:kPurchaseOverlayTag] addGestureRecognizer:tap];
        [self.exportButton setEnabled:NO];
    }
    else {
        if ([self.webView viewWithTag:kPurchaseOverlayTag]) {
            [self enable:self.webView];
            [self.webView reload];
            [self.exportButton setEnabled:YES];
        }
    }
}

- (void)tapOverlay:(id)tapOverlay {
    [[Purchaser new] purchase:IAP_GRAPHING];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.bridge callHandler:@"setGraphSize" data:[self getSize]];
    if ([[IAPAdapter instance] hasPurchased:IAP_GRAPHING]) {
        [self.bridge send:[[FTOLogGraphTransformer new] buildDataFromLog]];
    }
    else {
        [self.bridge callHandler:@"setupTestData" data:@{}];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.bridge callHandler:@"setGraphSize" data:[self getSize]];
}

- (NSDictionary *)getSize {
    NSNumber *width = @(CGRectGetWidth(self.webView.frame));
    NSNumber *height = @(CGRectGetHeight(self.webView.frame));
    NSDictionary *size = @{@"width" : width, @"height" : height};
    return size;
}

@end