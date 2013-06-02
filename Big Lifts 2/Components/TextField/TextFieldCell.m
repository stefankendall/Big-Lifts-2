#import "TextFieldCell.h"
#import "TextFieldWithCell.h"

@implementation TextFieldCell
@synthesize textField, indexPath;

- (void)awakeFromNib {
    [super awakeFromNib];
    textField.cell = self;
}

@end