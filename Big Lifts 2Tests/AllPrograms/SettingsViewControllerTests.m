#import "SettingsViewControllerTests.h"
#import "SettingsViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "PaddingTextField.h"

@implementation SettingsViewControllerTests

- (void)testSetsRoundToValueOnViewAppear {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    STAssertFalse([[controller.roundToField text] isEqualToString:@""], @"");
}

- (void)testSetsRoundingTypeValueOnAppear {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    STAssertFalse([[controller.roundingTypeField text] isEqualToString:@""], @"");
}

- (void)testChangesRoundToOnPickerChange {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    [controller pickerView:controller.roundToPicker didSelectRow:0 inComponent:0];
    JSettings *settings = [[JSettingsStore instance] first];
    STAssertEqualObjects(settings.roundTo, @1, @"");
    STAssertEqualObjects([controller.roundToField text], @"1", @"");
}

- (void)testChangesRoundingTypeOnPickerChange {
    STFail(@"write test yo!");
}

- (void)testSetsNearest5RoundTo {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    [controller pickerView:controller.roundToPicker didSelectRow:4 inComponent:0];
    JSettings *settings = [[JSettingsStore instance] first];
    STAssertEqualObjects(settings.roundTo, [NSDecimalNumber decimalNumberWithString:(NSString *) NEAREST_5_ROUNDING], @"");
    STAssertEqualObjects([controller.roundToField text], @"Nearest 5", @"");
}

- (void)testSelectsRoundingValueOnAppear {
    [[[JSettingsStore instance] first] setRoundTo:N(2.5)];
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    STAssertEquals((int) [controller.roundToPicker selectedRowInComponent:0], 2, @"");
}

- (void)testSetsKeepScreenOnAppear {
    [[[JSettingsStore instance] first] setScreenAlwaysOn:YES];
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    STAssertTrue([controller.keepScreenOnSwitch isOn], @"");
}

- (void)testCanChangeScreenOnPreference {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    [controller.keepScreenOnSwitch setOn:YES];
    [controller keepScreenOnChanged:controller.keepScreenOnSwitch];
    STAssertTrue([[[JSettingsStore instance] first] screenAlwaysOn], @"");
}

- (void)testCanEnableDisableAds {
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    [controller.adsSwitch setOn:NO];
    [controller adsOnChanged:controller.adsSwitch];
    STAssertFalse([[[JSettingsStore instance] first] adsEnabled], @"");

    [controller.adsSwitch setOn:YES];
    [controller adsOnChanged:controller.adsSwitch];
    STAssertTrue([[[JSettingsStore instance] first] adsEnabled], @"");
}

- (void)testSetsAdsSwitchOnAppear {
    [[[JSettingsStore instance] first] setAdsEnabled:YES];
    SettingsViewController *controller = [self getControllerByStoryboardIdentifier:@"settings"];
    STAssertTrue([controller.adsSwitch isOn], @"");

    [[[JSettingsStore instance] first] setAdsEnabled:NO];
    [controller viewWillAppear:NO];
    STAssertFalse([controller.adsSwitch isOn], @"");
}

@end