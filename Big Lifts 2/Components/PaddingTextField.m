#import "PaddingTextField.h"

@implementation PaddingTextField
- (CGRect)textRectForBounds:(CGRect)bounds {
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    return UIEdgeInsetsInsetRect(bounds, contentInsets);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}
@end