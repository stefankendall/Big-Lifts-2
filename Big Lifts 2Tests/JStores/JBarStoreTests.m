#import "JBarStoreTests.h"
#import "JBarStore.h"
#import "JBar.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation JBarStoreTests

- (void)testBarWeightHasDefaults {
    JBar *bar = [[JBarStore instance] first];
    STAssertEqualObjects([bar weight], N(45), @"");
}

- (void)testBarWeightAdjustsWithUnits {
    JSettings *settings = [[JSettingsStore instance] first];
    settings.units = @"kg";

    [[JBarStore instance] adjustForKg];
    JBar *bar = [[JBarStore instance] first];
    STAssertEqualObjects( [bar weight], N(20), @"");
}


@end