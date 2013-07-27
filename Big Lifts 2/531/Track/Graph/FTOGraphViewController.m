#import "FTOGraphViewController.h"
#import "WebViewJavascriptBridge.h"

@interface FTOGraphViewController ()

@property(nonatomic, strong) WebViewJavascriptBridge *bridge;
@end

@implementation FTOGraphViewController

- (void)viewDidLoad {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]
            pathForResource:@"graph" ofType:@"html"]                  isDirectory:NO]]];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:(WVJBHandler) ^{
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.bridge send:@{@"Data" : @[@1]}];
}


@end