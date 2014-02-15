#import "Migrate6to7Tests.h"
#import "Migrate1to2Tests.h"
#import "JSettings.h"
#import "Migrate6to7.h"
#import "JSettingsHelper.h"

@implementation Migrate6to7Tests

- (void)testAddsIsMaleToSettings {
    [JSettingsHelper writeSettings:@{
            @"uuid" : @"123",
            @"units" : @"kg",
            @"roundTo" : @"2.5",
            @"roundingFormula" : ROUNDING_FORMULA_EPLEY,
            @"screenAlwaysOn" : @0
    }];

    [[Migrate6to7 new] run];
    NSMutableDictionary *settings = [JSettingsHelper readSettings];
    STAssertEquals([settings[@"isMale"] intValue], 1, @"");
}

@end