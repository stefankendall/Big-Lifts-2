#import "SSSettingsViewController.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation SSSettingsViewController {
    __weak IBOutlet UISegmentedControl *unitsSegmentedControl;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData {
    Settings *settings = [[SettingsStore instance] settings];
    NSDictionary *unitsSegments = @{@"lbs" : @0, @"kg" : @1};
    [unitsSegmentedControl setSelectedSegmentIndex:[[unitsSegments objectForKey:settings.units] integerValue]];
}

- (IBAction)unitsChanged:(id)sender {
    UISegmentedControl *unitsControl = sender;
    NSArray *unitsMapping = @[@"lbs", @"kg"];
    [[[SettingsStore instance] settings] setUnits:unitsMapping[(NSUInteger) [unitsControl selectedSegmentIndex]]];
}

@end