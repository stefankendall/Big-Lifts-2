#import "JSettingsTests.h"
#import "JSettings.h"
#import "JSettingsStore.h"
#import "JFTOLift.h"
#import "JFTOLiftStore.h"

@implementation JSettingsTests

- (void)testAdjustsStoreValuesWhenKgSelected {
    [[[JSettingsStore instance] first] setUnits: @"kg"];
    JFTOLift *squat = [[JFTOLiftStore instance] find: @"name" value: @"Squat"];
    STAssertEqualObjects(squat.increment, N(5), @"");
}

@end