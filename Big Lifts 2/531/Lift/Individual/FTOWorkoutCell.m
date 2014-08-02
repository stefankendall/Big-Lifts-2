#import "FTOWorkoutCell.h"
#import "JSet.h"
#import "SetClassGenerator.h"

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
    Class setClass = [SetClassGenerator generate];
    self.setCell = [setClass create];
    UIView *contentView = self.setCell.contentView;
    [self addSubview:contentView];
}

- (void)setSet:(JSet *)set {
    [self.setCell setSet:set];
}

- (void)setSet:(JSet *)set withEnteredReps:(NSNumber *)enteredReps withEnteredWeight:(NSDecimalNumber *)weight {
    [self.setCell setSet:set withEnteredReps:enteredReps withEnteredWeight:weight];
}

@end