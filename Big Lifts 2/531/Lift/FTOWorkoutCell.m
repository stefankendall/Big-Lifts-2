#import "FTOWorkoutCell.h"
#import "Set.h"
#import "Lift.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation FTOWorkoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.setCell = [SetCell create];
    [self addSubview:self.setCell.contentView];
}

- (void)setSet:(Set *)set {
    [self.setCell.liftLabel setText:set.lift.name];
    [self.setCell.repsLabel setText:[NSString stringWithFormat:@"%dx", [set.reps intValue]]];

    Settings *settings = [[SettingsStore instance] first];

    [self.setCell.weightLabel setText:[NSString stringWithFormat:@"%0.0f %@",
                                                                 [[set effectiveWeight] doubleValue], settings.units]];
}

@end