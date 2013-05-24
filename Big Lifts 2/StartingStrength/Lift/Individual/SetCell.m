#import "SetCell.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "Lift.h"

@implementation SetCell
@synthesize liftLabel, repsLabel, weightLabel;

- (void)setSet:(Set *)set {
    [repsLabel setText:[NSString stringWithFormat:@"%dx", [[set reps] intValue]]];

    Settings *settings = [[SettingsStore instance] first];
    [weightLabel setText:[NSString stringWithFormat:@"%0.1f %@", [[set weight] doubleValue], settings.units]];

    [liftLabel setText:[set lift].name];
}
@end