#import "SetCell.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "Lift.h"

@implementation SetCell

- (void)setSet:(Set *)set {
    int reps = [[set reps] intValue];
    if (reps <= 0 && [set amrap]) {
        [self.repsLabel setText:@"AMRAP"];
    }
    else {
        if ([set amrap]) {
            [self.repsLabel setText:[NSString stringWithFormat:@"%d+", reps]];
            [self.repsLabel setTextColor:[UIColor greenColor]];
            [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        else {
            [self.repsLabel setText:[NSString stringWithFormat:@"%dx", reps]];
        }
    }

    Settings *settings = [[SettingsStore instance] first];
    [self.weightLabel setText:[NSString stringWithFormat:@"%0.1f %@",
                                                         [[set roundedEffectiveWeight] doubleValue], settings.units]];
    [self.liftLabel setText:[set lift].name];
    [self.optionalLabel setHidden:!set.optional];
}
@end