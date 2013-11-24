#import "JSettingsStoreTests.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation JSettingsStoreTests

- (void)testSettingsLazyLoadedWithDefaults {
    JSettings *settings = [[JSettingsStore instance] first];
    STAssertNotNil(settings, @"");
    STAssertTrue([settings.units isEqualToString:@"lbs"], @"%@");
    STAssertTrue([settings.roundTo isEqualToNumber:@5], @"%@");
}

- (void)testSettingsCanBeUpdated {
    JSettings *settings = [[JSettingsStore instance] first];
    settings.units = @"kg";

    JSettings *nextSettings = [[JSettingsStore instance] first];
    STAssertEquals(nextSettings.units, @"kg", @"");
}

- (void)testAdjustsRoundToWhenKgSelected {
    JSettings *settings = [[JSettingsStore instance] first];
    settings.units = @"kg";
    [[JSettingsStore instance] adjustForKg];
    STAssertEqualObjects(settings.roundTo, @1, @"");
}

- (void)testSetsUpDefaultRoundingOnLoad {
    JSettings *settings = [[JSettingsStore instance] first];
    STAssertNotNil(settings.roundingFormula, @"");
    settings.roundingFormula = nil;
    [[JSettingsStore instance] onLoad];
    STAssertNotNil(settings.roundingFormula, @"");
}

@end