#import "LiftFormCell.h"
#import "TextFieldWithCell.h"

@implementation LiftFormCell
@synthesize liftLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    [[self liftLabel] setAdjustsFontSizeToFitWidth:YES];
    [[self textField] setKeyboardType:UIKeyboardTypeDecimalPad];
}


@end