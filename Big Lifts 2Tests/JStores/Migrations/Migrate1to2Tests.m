#import "Migrate1to2Tests.h"
#import "JSettingsStore.h"
#import "Migrate1to2.h"
#import "JSettings.h"

@implementation Migrate1to2Tests

- (void)testAddsScreenOnPropertyToSettings {
    NSDictionary *settingsV1 = @{
            @"uuid" : @"123",
            @"units" : @"kg",
            @"roundTo" : @"2.5",
            @"roundingFormula" : ROUNDING_FORMULA_EPLEY
    };
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:settingsV1 options:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[NSUbiquitousKeyValueStore defaultStore] setObject:@[jsonString] forKey:[[JSettingsStore instance] keyNameForStore]];

    [[Migrate1to2 new] run];
    [[JSettingsStore instance] load];
    JSettings *settings = [[JSettingsStore instance] first];

    STAssertEqualObjects(settings.units, @"kg", @"");
    STAssertEqualObjects(settings.roundTo, N(2.5), @"");
    STAssertEqualObjects(settings.roundingFormula, ROUNDING_FORMULA_EPLEY, @"");
    STAssertEquals(settings.screenAlwaysOn, NO, @"");
}

@end