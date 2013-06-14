#import <ViewDeck/IIViewDeckController.h>
#import "UIViewController+ViewDeckAdditions.h"

@implementation UIViewController (ViewDeckAdditions)

- (IBAction)revealSidebar:(id)sender {
    [self.view endEditing:YES];
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

@end