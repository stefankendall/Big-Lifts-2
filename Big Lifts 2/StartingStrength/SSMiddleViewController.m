#import "SSMiddleViewController.h"
#import "IIViewDeckController.h"

@implementation SSMiddleViewController {

}

- (IBAction)revealSidebar:(id)sender {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}
@end