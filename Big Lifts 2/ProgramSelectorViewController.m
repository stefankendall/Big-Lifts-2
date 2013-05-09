#import "ProgramSelectorViewController.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation ProgramSelectorViewController {
}

- (IBAction)unitsChanged:(id)sender {
    UISegmentedControl *unitsControl = sender;
    NSArray *unitsMapping = @[@"lbs", @"kg"];
    [[[SettingsStore instance] settings] setUnits:unitsMapping[(NSUInteger) [unitsControl selectedSegmentIndex]]];
}

@end