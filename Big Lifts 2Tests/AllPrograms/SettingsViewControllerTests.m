#import "SettingsViewControllerTests.h"
#import "SettingsViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"

@implementation SettingsViewControllerTests

- (void)testSetsRoundToValueOnViewAppear {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    STAssertFalse([[controller.roundToField text] isEqualToString:@""], @"");
}

@end