#import "Settings.h"
#import "SettingsStoreTests.h"
#import "SettingsStore.h"

@implementation SettingsStoreTests

- (void)testSettingsLazyLoadedWithDefaults {
    Settings *settings = [[SettingsStore instance] first];
    STAssertNotNil(settings, @"");
    STAssertTrue([settings.units isEqualToString:@"lbs"], @"%@");
    STAssertTrue([settings.roundTo isEqualToNumber:@5], @"%@");
}

- (void)testSettingsCanBeUpdated {
    Settings *settings = [[SettingsStore instance] first];
    settings.units = @"kg";

    Settings *nextSettings = [[SettingsStore instance] first];
    STAssertEquals(nextSettings.units, @"kg", @"");
}

- (void)testAdjustsRoundToWhenKgSelected {
    Settings *settings = [[SettingsStore instance] first];
    settings.units = @"kg";
    [[SettingsStore instance] adjustForKg];
    STAssertEqualObjects(settings.roundTo, @1, @"");
}

@end