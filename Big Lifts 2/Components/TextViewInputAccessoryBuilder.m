#import "TextViewInputAccessoryBuilder.h"

@implementation TextViewInputAccessoryBuilder

- (UIView *)doneButtonAccessory:(UITextField *)textField {
    UIToolbar *toolbar = [UIToolbar new];
    [toolbar sizeToFit];

    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                   target:textField action:@selector(resignFirstResponder)];
    toolbar.items = @[flexBarButton, doneBarButton];
    textField.inputAccessoryView = toolbar;
    return toolbar;
}

@end