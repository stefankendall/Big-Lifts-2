#import "TextViewInputAccessoryBuilder.h"

@implementation TextViewInputAccessoryBuilder

- (UIView *)doneButtonAccessory:(UITextField *)textField {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:textField action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setBarTintColor:[UIColor colorWithRed:214/255.0f green:214/255.0f blue:214/255.0f alpha:1.0f]];
    toolbar.items = @[barButton];

    textField.inputAccessoryView = toolbar;
    return toolbar;
}

@end