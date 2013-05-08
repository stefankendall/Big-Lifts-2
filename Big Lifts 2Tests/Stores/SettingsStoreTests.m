#import "SettingsStoreTests.h"
#import "SettingsStore.h"

@implementation SettingsStoreTests
- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSettingsLazyLoadedWithDefaults {
    Settings *settings = [[SettingsStore instance] settings];
    STAssertNotNil(settings, @"");
}

@end