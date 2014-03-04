#import "Migrate11to12Tests.h"
#import "JSettingsHelper.h"
#import "Migrate11to12.h"

@implementation Migrate11to12Tests

- (void)testRemovesAdsOnPropertyFromSettings {
    [JSettingsHelper writeSettings:@{
            @"adsEnabled" : @1
    }];

    [[Migrate11to12 new] run];

    NSDictionary *settings = [JSettingsHelper readSettings];
    STAssertFalse([[settings allKeys] containsObject:@"adsEnabled"], @"");
}

@end