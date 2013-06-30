#import "ProgramSelectorViewControllerTests.h"
#import "ProgramSelectorViewController.h"
#import "CurrentProgramStore.h"
#import "CurrentProgram.h"
#import "BLStoreManager.h"

@implementation ProgramSelectorViewControllerTests

- (void)testRemembersSelectedProgram {
    ProgramSelectorViewController *controller = [ProgramSelectorViewController new];
    [controller rememberSelectedProgram:@"selectStartingStrengthProgramSegue"];

    CurrentProgramStore *store = [CurrentProgramStore instance];
    STAssertEquals([store count], 1, @"");
    CurrentProgram *program = [store first];
    STAssertTrue([[program name] isEqualToString:@"Starting Strength"], @"");
}

- (void)testRemembersSelectedProgramOverwritesExistingProgram {
    ProgramSelectorViewController *controller = [ProgramSelectorViewController new];

    CurrentProgramStore *store = [CurrentProgramStore instance];
    CurrentProgram *program = [store create];
    program.name = @"5/3/1";

    [controller rememberSelectedProgram:@"selectStartingStrengthProgramSegue"];
    STAssertTrue([[program name] isEqualToString:@"Starting Strength"], @"");
}


@end