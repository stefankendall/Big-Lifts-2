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


    NSDecimalNumber *weight = [[set.lift.weight decimalNumberByMultiplyingBy:set.percentage]
            decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    [self.setCell.weightLabel setText:[NSString stringWithFormat:@"%0.1f %@", [weight doubleValue], settings.units]];
}

@end