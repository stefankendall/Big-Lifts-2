#import "JFTOSSTLiftStore.h"
#import "JFTOSSTLift.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "Migrate16to17Tests.h"
#import "Migrate16to17.h"

@implementation Migrate16to17Tests

- (void)testSetsBarLoadingEnabledToTrue {
    JSettings *settings = [[JSettingsStore instance] first];
    settings.barLoadingEnabled = NO;
    [[JSettingsStore instance] sync];
    [[Migrate16to17 new] run];
    [[JSettingsStore instance] load];
    STAssertTrue([[[JSettingsStore instance] first] barLoadingEnabled], @"");
}

@end