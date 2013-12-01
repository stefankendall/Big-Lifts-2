#import "SettingsViewControllerTests.h"
#import "SettingsViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation SettingsViewControllerTests

- (void)testSetsRoundToValueOnViewAppear {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    STAssertFalse([[controller.roundToField text] isEqualToString:@""], @"");
}

- (void)testChangesRoundToOnPickerChange {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    [controller pickerView:nil didSelectRow:0 inComponent:0];
    JSettings *settings = [[JSettingsStore instance] first];
    STAssertEqualObjects(settings.roundTo, @1, @"");
    STAssertEqualObjects([controller.roundToField text], @"1", @"");
}

- (void)testSetsNearest5RoundTo {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    [controller pickerView:nil didSelectRow:3 inComponent:0];
    JSettings *settings = [[JSettingsStore instance] first];
    STAssertEqualObjects(settings.roundTo, [NSDecimalNumber decimalNumberWithString:(NSString *) NEAREST_5_ROUNDING], @"");
    STAssertEqualObjects([controller.roundToField text], @"Nearest 5", @"");
}

- (void)testSelectsRoundingValueOnAppear {
    [[[JSettingsStore instance] first] setRoundTo:N(2.5)];
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    STAssertEquals([controller.roundToPicker selectedRowInComponent:0], 1, @"");
}

@end