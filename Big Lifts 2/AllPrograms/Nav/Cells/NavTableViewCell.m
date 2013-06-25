#import "NavTableViewCell.h"

@implementation NavTableViewCell

- (void)setFrame:(CGRect)frame {
    frame.size.width -= self.rightMargin;
    [super setFrame:frame];
}



@end