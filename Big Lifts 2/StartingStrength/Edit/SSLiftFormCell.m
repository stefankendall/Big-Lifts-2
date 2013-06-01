#import "SSLiftFormCell.h"
#import "TextFieldWithCell.h"

@implementation SSLiftFormCell
@synthesize liftLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    [[self liftLabel] setAdjustsFontSizeToFitWidth:YES];
    [[self textField] setKeyboardType:UIKeyboardTypeDecimalPad];
}


@end