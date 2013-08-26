#import <ViewDeck/IIViewDeckController.h>
#import "ProgramSelectorViewController.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "CurrentProgramStore.h"
#import "CurrentProgram.h"
#import "NSDictionaryMutator.h"
#import "BLViewDeckController.h"

@interface ProgramSelectorViewController ()
@property(nonatomic) BOOL firstTimeInApp;
@end

@implementation ProgramSelectorViewController

- (void)awakeFromNib {
    [self chooseSavedProgram];
}

- (NSDictionary *)segueToProgramNames {
    return @{
            @"ssSegue" : @"Starting Strength",
            @"531segue" : @"5/3/1",
            @"smolovJrSegue" : @"Smolov Jr"
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
    id destinationController = [segue destinationViewController];
    if ([destinationController isKindOfClass:BLViewDeckController.class]) {
        BLViewDeckController *destination = destinationController;
        if (self.firstTimeInApp) {
            [destination firstTimeInApp];
        }
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end