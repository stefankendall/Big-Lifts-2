#import "Settings.h"
#import "SettingsStoreTests.h"
#import "SettingsStore.h"

@implementation SettingsStoreTests
- (void)setUp {
    [super setUp];
    [[SettingsStore instance] empty];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSettingsLazyLoadedWithDefaults {
    Settings *settings = [[SettingsStore instance] settings];
    STAssertNotNil(settings, @"");
    STAssertTrue([settings.units isEqualToString:@"lbs"], @"");
}

- (void)testSettingsCanBeUpdated {
    Settings *settings = [[SettingsStore instance] settings];
    settings.units = @"kg";
    STAssertEquals([[SettingsStore instance] settings].units, @"kg", @"");
}

@end