#import "SSSettingsViewController.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation SSSettingsViewController {
    __weak IBOutlet UISegmentedControl *unitsSegmentedControl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadData];
}

- (void)reloadData {
    Settings *settings = [[SettingsStore instance] settings];
    NSDictionary *unitsSegments = @{@"lbs" : @0, @"kg" : @1};
    NSLog(@"%@", settings.units);
    [unitsSegmentedControl setSelectedSegmentIndex:[[unitsSegments objectForKey:settings.units] integerValue]];
}


@end