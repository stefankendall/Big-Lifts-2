#import "FTOGraphViewController.h"
#import "WebViewJavascriptBridge.h"
#import "FTOLogGraphTransformer.h"

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

- (void)viewWillAppear:(BOOL)animated {
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.bridge callHandler:@"setGraphSize" data:[self getSize]];
    [self.bridge send:[[FTOLogGraphTransformer new] buildDataFromLog]];
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