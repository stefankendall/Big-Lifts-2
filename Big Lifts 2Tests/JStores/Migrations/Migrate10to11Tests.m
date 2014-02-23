#import "Migrate10to11Tests.h"
#import "JFTOSettingsHelper.h"
#import "Migrate10to11.h"
#import "JSettings.h"

@implementation Migrate10to11Tests

- (void)testAddsRoundingTypeToSettings {
    [JFTOSettingsHelper writeSettings:@{
            @"trainingMax" : @90,
            @"repsToBeatConfig" : @0,
            @"uuid" : @"1",
            @"warmupEnabled" : @1,
            @"logState" : @0
    }];
    [[Migrate10to11 new] run];
    STAssertEqualObjects([JFTOSettingsHelper readSettings][@"roundingType"], ROUNDING_TYPE_NORMAL, @"");
}

@end