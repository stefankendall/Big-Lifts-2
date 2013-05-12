#import "Settings.h"
#import "SettingsStoreTests.h"
#import "SettingsStore.h"

@implementation SettingsStoreTests
- (void)setUp {
    [super setUp];
    [[SettingsStore instance] empty];
    [[SettingsStore instance] setupDefaults];
}

- (void)tearDown {
    [super tearDown];
}

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