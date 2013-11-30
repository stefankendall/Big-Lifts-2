#import <ViewDeck/IIViewDeckController.h>
#import "ProgramSelectorViewController.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "BLViewDeckController.h"
#import "JCurrentProgramStore.h"
#import "JCurrentProgram.h"

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
    [[[JSettingsStore instance] first] setUnits:unitsMapping[(NSUInteger) [unitsControl selectedSegmentIndex]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadData];
}

- (void)reloadData {
    JSettings *settings = [[JSettingsStore instance] first];
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
    JCurrentProgramStore *store = [JCurrentProgramStore instance];
    JCurrentProgram *program = [store first];
    if (!program) {
        self.firstTimeInApp = YES;
        program = [store create];
    }

    program.name = [self segueToProgramNames][segueName];
}

@end