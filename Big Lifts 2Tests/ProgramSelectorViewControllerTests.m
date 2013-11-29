#import "ProgramSelectorViewControllerTests.h"
#import "ProgramSelectorViewController.h"
#import "JCurrentProgramStore.h"
#import "JCurrentProgram.h"

@implementation ProgramSelectorViewControllerTests

- (void)testRemembersSelectedProgram {
    ProgramSelectorViewController *controller = [ProgramSelectorViewController new];
    [controller rememberSelectedProgram:@"ssSegue"];

    JCurrentProgramStore *store = [JCurrentProgramStore instance];
    STAssertEquals([store count], 1, @"");
    JCurrentProgram *program = [store first];
    STAssertTrue([[program name] isEqualToString:@"Starting Strength"], @"");
}

- (void)testRemembersSelectedProgramOverwritesExistingProgram {
    ProgramSelectorViewController *controller = [ProgramSelectorViewController new];

    JCurrentProgramStore *store = [JCurrentProgramStore instance];
    JCurrentProgram *program = [store create];
    program.name = @"5/3/1";

    [controller rememberSelectedProgram:@"ssSegue"];
    STAssertTrue([[program name] isEqualToString:@"Starting Strength"], @"");
}


@end