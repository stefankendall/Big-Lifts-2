#import "FTOSettingsStoreTests.h"
#import "FTOSettingsStore.h"
#import "FTOSettings.h"

@implementation FTOSettingsStoreTests

- (void)testDefaultsTrainingMaxTo90 {
    FTOSettings *settings = [[FTOSettingsStore instance] first];
    STAssertEqualObjects(settings.trainingMax, @90, @"");
}

@end