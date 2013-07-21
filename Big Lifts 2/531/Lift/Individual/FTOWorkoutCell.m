#import "FTOWorkoutCell.h"
#import "Set.h"

@implementation FTOWorkoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.setCell = [SetCell create];
    UIView *contentView = self.setCell.contentView;
    [self shiftContentViewLeftForDisclosure:contentView];
    [self addSubview:contentView];
}

- (void)shiftContentViewLeftForDisclosure:(UIView *)contentView {
    int padding = 10;
    contentView.bounds = CGRectInset(contentView.frame, padding, 0);
    CGRect bounds = contentView.bounds;
    [contentView setBounds:CGRectMake(bounds.origin.x - padding, bounds.origin.x, bounds.size.width, bounds.size.height)];
}

- (void)setSet:(Set *)set {
    [self.setCell setSet:set];

    if ([set amrap]) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
}

@end