#import <ViewDeck/IIViewDeckController.h>
#import "ProgramSelectorViewController.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "CurrentProgramStore.h"
#import "CurrentProgram.h"
#import "NSDictionaryMutator.h"
#import "BLViewDeckController.h"

@implementation ProgramSelectorViewController {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self chooseSavedProgram];
}

- (NSDictionary *)segueToProgramNames {
    return @{
            @"selectStartingStrengthProgramSegue" : @"Starting Strength",
            @"531segue" : @"5/3/1"
    };
}

- (void)chooseSavedProgram {
    CurrentProgram *program = [[CurrentProgramStore instance] first];
    if (program.name) {
        NSDictionary *namesToSegues = [[NSDictionaryMutator new] invert:[self segueToProgramNames]];
        NSString *segueName = namesToSegues[program.name];
        [self performSegueWithIdentifier:segueName sender:self];
    }
}

- (IBAction)unitsChanged:(id)sender {
    UISegmentedControl *unitsControl = sender;
    NSArray *unitsMapping = @[@"lbs", @"kg"];
    [[[SettingsStore instance] first] setUnits:unitsMapping[(NSUInteger) [unitsControl selectedSegmentIndex]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData {
    Settings *settings = [[SettingsStore instance] first];
    NSDictionary *unitsSegments = @{@"lbs" : @0, @"kg" : @1};
    [unitsSegmentedControl setSelectedSegmentIndex:[[unitsSegments objectForKey:settings.units] integerValue]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BLViewDeckController *destination = [segue destinationViewController];
    if ([[CurrentProgramStore instance] first] == nil) {
        [destination firstTimeInApp];
    }

    [self rememberSelectedProgram:[segue identifier]];
}

- (void)rememberSelectedProgram:(NSString *)segueName {
    CurrentProgramStore *store = [CurrentProgramStore instance];
    CurrentProgram *program = [store first];
    if (!program) {
        program = [store create];
    }

    program.name = [self segueToProgramNames][segueName];
}

@end