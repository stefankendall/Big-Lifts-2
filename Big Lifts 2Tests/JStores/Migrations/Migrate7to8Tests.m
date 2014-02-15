#import "Migrate7to8Tests.h"
#import "JSettingsHelper.h"
#import "JSettings.h"
#import "Migrate7to8.h"

@implementation Migrate7to8Tests

- (void)testAddsAdsEnabledToSettings {
    [JSettingsHelper writeSettings:@{
            @"uuid" : @"123",
            @"units" : @"kg",
            @"roundTo" : @"2.5",
            @"roundingFormula" : ROUNDING_FORMULA_EPLEY,
            @"screenAlwaysOn" : @0,
            @"isMale" : @0
    }];

    [[Migrate7to8 new] run];
    NSMutableDictionary *settings = [JSettingsHelper readSettings];
    STAssertEquals([settings[@"adsEnabled"] intValue], 0, @"");
}

@end