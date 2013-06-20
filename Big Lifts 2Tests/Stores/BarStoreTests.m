#import "BarStoreTests.h"
#import "BLStoreManager.h"
#import "BarStore.h"
#import "Bar.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation BarStoreTests

- (void)testBarWeightHasDefaults {
    Bar *bar = [[BarStore instance] first];
    STAssertEquals( [[bar weight] doubleValue], 45.0, @"");
}

- (void)testBarWeightAdjustsWithUnits {
    Settings *settings = [[SettingsStore instance] first];
    settings.units = @"kg";

    [[BarStore instance] adjustWeightForSettings];
    Bar *bar = [[BarStore instance] first];
    STAssertEquals( [[bar weight] doubleValue], 20.4, @"");
}

@end