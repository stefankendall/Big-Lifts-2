#import "Settings.h"
#import "SettingsStoreTests.h"
#import "SettingsStore.h"

@implementation SettingsStoreTests

- (void)testSettingsLazyLoadedWithDefaults {
    Settings *settings = [[SettingsStore instance] first];
    STAssertNotNil(settings, @"");
    STAssertTrue([settings.units isEqualToString:@"lbs"], @"%@");
}

- (void)testSettingsCanBeUpdated {
    Settings *settings = [[SettingsStore instance] first];
    settings.units = @"kg";

    Settings *nextSettings = [[SettingsStore instance] first];
    STAssertEquals(nextSettings.units, @"kg", @"");
}

@end