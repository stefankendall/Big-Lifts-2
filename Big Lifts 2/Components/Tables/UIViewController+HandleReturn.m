#import "UIViewController+HandleReturn.h"

@implementation UIViewController (HandleReturn)

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end