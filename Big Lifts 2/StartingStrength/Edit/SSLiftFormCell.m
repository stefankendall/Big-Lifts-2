#import "SSLiftFormCell.h"

@implementation SSLiftFormCell
@synthesize liftLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    [[self liftLabel] setAdjustsFontSizeToFitWidth:YES];
}


@end