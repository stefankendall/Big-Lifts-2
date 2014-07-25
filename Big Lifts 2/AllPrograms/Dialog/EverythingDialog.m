#import "EverythingDialog.h"

@implementation EverythingDialog

- (void)show {
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"Unlock Everything!"
                  message:@"There is now a single purchase available to unlock all features. Forever. Available in Settings."
                 delegate:self
        cancelButtonTitle:nil
        otherButtonTitles:nil];
    [alert addButtonWithTitle:@"Okay"];
    [alert show];
}

@end