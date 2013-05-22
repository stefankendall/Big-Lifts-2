#import "TextViewCell.h"
#import "TextViewWithCell.h"

@implementation TextViewCell
@synthesize textView, indexPath;

- (void)awakeFromNib {
    [super awakeFromNib];
    textView.cell = self;
}

@end