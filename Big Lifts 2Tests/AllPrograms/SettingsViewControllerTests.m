#import "SettingsViewControllerTests.h"
#import "SettingsViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "BLStore.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation SettingsViewControllerTests

- (void)testSetsRoundToValueOnViewAppear {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    STAssertFalse([[controller.roundToField text] isEqualToString:@""], @"");
}

- (void) testChangesRoundToOnPickerChange {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    [controller pickerView:nil didSelectRow:0 inComponent:0];
    Settings *settings = [[SettingsStore instance] first];
    STAssertEqualObjects(settings.roundTo, @1, @"");
    STAssertEqualObjects([controller.roundToField text], @"1", @"");
}

- (void) testSelectsRoundingValueOnAppear {
    [[[SettingsStore instance] first] setRoundTo:N(2.5)];
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    STAssertEquals([controller.roundToPicker selectedRowInComponent:0], 1, @"");
}

@end