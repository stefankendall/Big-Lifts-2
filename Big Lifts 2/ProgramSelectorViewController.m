#import <ViewDeck/IIViewDeckController.h>
#import "ProgramSelectorViewController.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "CurrentProgramStore.h"
#import "CurrentProgram.h"
#import "BLViewDeckController.h"

@interface ProgramSelectorViewController ()
@property(nonatomic) BOOL firstTimeInApp;
@end

@implementation ProgramSelectorViewController

- (NSDictionary *)segueToProgramNames {
    return @{
            @"ssSegue" : @"Starting Strength",
            @"531segue" : @"5/3/1",
            @"smolovJrSegue" : @"Smolov Jr"
    };
}

- (IBAction)unitsChanged:(id)sender {
    UISegmentedControl *unitsControl = sender;
    NSArray *unitsMapping = @[@"lbs", @"kg"];
    [[[SettingsStore instance] first] setUnits:unitsMapping[(NSUInteger) [unitsControl selectedSegmentIndex]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadData];
}

- (void)reloadData {
    Settings *settings = [[SettingsStore instance] first];
    NSDictionary *unitsSegments = @{@"lbs" : @0, @"kg" : @1};
    [unitsSegmentedControl setSelectedSegmentIndex:[[unitsSegments objectForKey:settings.units] integerValue]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destinationController = [segue destinationViewController];
    if ([destinationController isKindOfClass:BLViewDeckController.class]) {
        BLViewDeckController *destination = destinationController;
        [destination firstTimeInApp];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([[self.segueToProgramNames allKeys] containsObject:identifier]) {
        [self rememberSelectedProgram:identifier];
    }
    return YES;
}

- (void)rememberSelectedProgram:(NSString *)segueName {
    CurrentProgramStore *store = [CurrentProgramStore instance];
    CurrentProgram *program = [store first];
    if (!program) {
        self.firstTimeInApp = YES;
        program = [store create];
    }

    program.name = [self segueToProgramNames][segueName];
}

@end