#import "FTOWorkoutCell.h"
#import "Set.h"
#import "Lift.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "FTOSet.h"
#import "WeightRounder.h"

@implementation FTOWorkoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.setCell = [SetCell create];
    [self addSubview:self.setCell.contentView];
}

- (void)setSet:(Set *)set {
    FTOSet *ftoSet = (FTOSet *) set;
    [self.setCell.liftLabel setText:set.lift.name];

    [self.setCell.repsLabel setText:[NSString stringWithFormat:@"%d%@", [set.reps intValue],
                                                               ftoSet.amrap ? @"+" : @"x"]];
    if (ftoSet.amrap) {
        [self.setCell.repsLabel setTextColor:[UIColor colorWithRed:0 green:170 / 255.0 blue:0 alpha:1]];
    }

    Settings *settings = [[SettingsStore instance] first];

    NSString *weightText = [NSString stringWithFormat:@"%@ %@",
                                                      [[WeightRounder new] round:[set effectiveWeight]], settings.units];
    [self.setCell.weightLabel setText:weightText];
}

@end