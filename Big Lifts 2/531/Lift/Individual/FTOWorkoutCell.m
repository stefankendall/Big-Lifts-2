#import "FTOWorkoutCell.h"
#import "Set.h"
#import "SetCellWithPlates.h"
#import "Purchaser.h"
#import "IAPAdapter.h"

@implementation FTOWorkoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSetCell];
}

- (void)prepareForReuse {
    [self.setCell.contentView removeFromSuperview];
    [self addSetCell];
}

- (void)addSetCell {
    Class setClass = [[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING] ? SetCellWithPlates.class : SetCell.class;
    self.setCell = [setClass create];
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

    if ([set hasVariableReps]) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
}

- (void)setSet:(Set *)set withEnteredReps:(int)enteredReps {
    [self.setCell setEnteredReps:enteredReps];
    [self.setCell setSet:set];
}


@end