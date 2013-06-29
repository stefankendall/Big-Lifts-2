#import "FTOWorkoutCell.h"
#import "Set.h"
#import "Lift.h"

@implementation FTOWorkoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.setCell = [SetCell create];
    [self addSubview:self.setCell.contentView];
}

- (void)setSet:(Set *)set {
    [self.setCell.liftLabel setText:set.lift.name];
}

@end