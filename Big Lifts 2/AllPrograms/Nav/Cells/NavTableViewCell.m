#import "NavTableViewCell.h"

@implementation NavTableViewCell
@synthesize rightMargin;

- (void)setFrame:(CGRect)frame {
    frame.size.width -= [self rightMargin];
    [super setFrame:frame];
}

@end