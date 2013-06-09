#import "SetCell.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "Lift.h"

@implementation SetCell

- (void)setSet:(Set *)set {
    [self.repsLabel setText:[NSString stringWithFormat:@"%dx", [[set reps] intValue]]];

    Settings *settings = [[SettingsStore instance] first];
    [self.weightLabel setText:[NSString stringWithFormat:@"%0.1f %@", [[set weight] doubleValue], settings.units]];

    [self.liftLabel setText:[set lift].name];
}
@end