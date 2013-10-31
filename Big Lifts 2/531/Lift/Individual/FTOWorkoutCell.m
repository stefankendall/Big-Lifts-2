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
    [self addSubview:contentView];
}

- (void)setSet:(Set *)set {
    [self.setCell setSet:set];
}

- (void)setSet:(Set *)set withEnteredReps:(NSNumber *)enteredReps withEnteredWeight:(NSDecimalNumber *)weight {
    [self.setCell setSet:set withEnteredReps:enteredReps withEnteredWeight: weight];
}

@end