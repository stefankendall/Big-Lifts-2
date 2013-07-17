#import "FTOWorkoutCell.h"
#import "Set.h"
#import "Lift.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "FTOSet.h"

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
    FTOSet *ftoSet = (FTOSet *) set;
    [self.setCell.liftLabel setText:set.lift.name];

    [self.setCell.repsLabel setText:[NSString stringWithFormat:@"%d%@", [set.reps intValue],
                                                               ftoSet.amrap ? @"+" : @"x"]];
    if (ftoSet.amrap) {
        [self.setCell.repsLabel setTextColor:[UIColor colorWithRed:0 green:170 / 255.0 blue:0 alpha:1]];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }

    Settings *settings = [[SettingsStore instance] first];

    NSString *weightText = [NSString stringWithFormat:@"%@ %@",
                                                      [set roundedEffectiveWeight], settings.units];
    [self.setCell.weightLabel setText:weightText];
}

@end