#import "EverythingDialog.h"

@implementation EverythingDialog

- (void)show {
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"Unlock Everything!"
                  message:@"There is now a single purchase available to unlock all features. Forever."
                 delegate:self
        cancelButtonTitle:nil
        otherButtonTitles:nil];
    self.noButtonIndex = [alert addButtonWithTitle:@"No"];
    self.yesButtonIndex = [alert addButtonWithTitle:@"Yes"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == self.yesButtonIndex) {

    }
}

@end