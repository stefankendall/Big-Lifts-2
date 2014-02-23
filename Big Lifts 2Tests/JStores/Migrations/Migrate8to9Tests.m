#import "Migrate8to9Tests.h"
#import "JFTOSettingsHelper.h"
#import "Migrate8to9.h"

@implementation Migrate8to9Tests

- (void)testAddsSixWeekEnabledSettings {
    [JFTOSettingsHelper writeSettings:@{
            @"trainingMax" : @90,
            @"repsToBeatConfig" : @0,
            @"uuid" : @"1",
            @"warmupEnabled" : @1,
            @"logState" : @0
    }];
    [[Migrate8to9 new] run];
    STAssertEqualObjects([JFTOSettingsHelper readSettings][@"sixWeekEnabled"], @0, @"");
}

@end