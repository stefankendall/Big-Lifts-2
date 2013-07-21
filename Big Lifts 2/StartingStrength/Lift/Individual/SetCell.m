#import "SetCell.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "Lift.h"

@implementation SetCell

- (void)setSet:(Set *)set {
    if ([[set reps] intValue] <= 0 && [set amrap]) {
        [self.repsLabel setText:@"AMRAP"];
    }
    else {
        [self.repsLabel setText:[NSString stringWithFormat:@"%dx", [[set reps] intValue]]];
    }

    Settings *settings = [[SettingsStore instance] first];
    [self.weightLabel setText:[NSString stringWithFormat:@"%0.1f %@",
                                                         [[set roundedEffectiveWeight] doubleValue], settings.units]];
    [self.liftLabel setText:[set lift].name];
}
@end