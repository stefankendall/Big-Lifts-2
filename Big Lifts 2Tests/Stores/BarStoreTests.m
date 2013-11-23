#import "BarStoreTests.h"
#import "BLStoreManager.h"
#import "BarStore.h"
#import "Bar.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation BarStoreTests

- (void)testBarWeightHasDefaults {
    Bar *bar = [[BarStore instance] first];
    STAssertEqualObjects([bar weight], N(45), @"");
}

- (void)testBarWeightAdjustsWithUnits {
    Settings *settings = [[SettingsStore instance] first];
    settings.units = @"kg";

    [[BarStore instance] adjustWeightForSettings];
    Bar *bar = [[BarStore instance] first];
    STAssertEqualObjects( [bar weight], N(20), @"");
}

@end