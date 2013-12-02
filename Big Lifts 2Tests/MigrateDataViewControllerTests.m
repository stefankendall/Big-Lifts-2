#import "MigrateDataViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "MigrateDataViewController.h"

@implementation MigrateDataViewControllerTests

- (void)testMarksWhetherTheMigrationPromptHasBeenSeen {
    MigrateDataViewController *controller = [self getControllerByStoryboardIdentifier:@"migrateView"];
    [controller markHasSeenMigrationPrompt:NO];
    STAssertFalse([controller hasSeenMigrationPrompt], @"");

    [controller markHasSeenMigrationPrompt:YES];
    STAssertTrue([controller hasSeenMigrationPrompt], @"");
}

@end