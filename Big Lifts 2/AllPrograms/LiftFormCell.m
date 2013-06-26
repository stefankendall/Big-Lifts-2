#import "LiftFormCell.h"
#import "TextFieldWithCell.h"

@implementation LiftFormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[self liftLabel] setAdjustsFontSizeToFitWidth:YES];
    [[self textField] setKeyboardType:UIKeyboardTypeDecimalPad];

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [self addGestureRecognizer:singleTap];
}

- (void)cellTapped:(id)sender {
    UITapGestureRecognizer *recognizer = sender;
    LiftFormCell *cell = (LiftFormCell *) recognizer.view;
    [cell.textField becomeFirstResponder];
}

@end