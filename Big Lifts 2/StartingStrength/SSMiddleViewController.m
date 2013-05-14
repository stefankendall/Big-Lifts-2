#import "SSMiddleViewController.h"
#import "IIViewDeckController.h"

@implementation SSMiddleViewController

- (IBAction)revealSidebar:(id)sender {
    [self.view endEditing:YES];
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

@end