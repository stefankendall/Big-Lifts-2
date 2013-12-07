#import "Migrate1to2Tests.h"
#import "JSettingsStore.h"
#import "Migrate1to2.h"
#import "JSettings.h"
#import "JVersionStore.h"
#import "JVersion.h"

@implementation Migrate1to2Tests

- (void)setUp {
    [super setUp];
    JVersion *version = [[JVersionStore instance] first];
    version.version = @2;
}

- (void)testAddsScreenOnPropertyToSettings {
    [self writeSettings:@{
            @"uuid" : @"123",
            @"units" : @"kg",
            @"roundTo" : @"2.5",
            @"roundingFormula" : ROUNDING_FORMULA_EPLEY
    }];

    [[Migrate1to2 new] run];
    [[JSettingsStore instance] load];
    JSettings *settings = [[JSettingsStore instance] first];

    STAssertEqualObjects(settings.units, @"kg", @"");
    STAssertEqualObjects(settings.roundTo, N(2.5), @"");
    STAssertEqualObjects(settings.roundingFormula, ROUNDING_FORMULA_EPLEY, @"");
    STAssertEquals(settings.screenAlwaysOn, NO, @"");
}

- (void)testDoesNotOverwriteScreenOnSettingIfExists {
    [self writeSettings:@{
            @"uuid" : @"123",
            @"units" : @"kg",
            @"roundTo" : @"2.5",
            @"roundingFormula" : ROUNDING_FORMULA_EPLEY,
            @"screenAlwaysOn" : @1
    }];

    [[Migrate1to2 new] run];
    [[JSettingsStore instance] load];
    JSettings *settings = [[JSettingsStore instance] first];

    STAssertEquals(settings.screenAlwaysOn, YES, @"");
}

- (void)writeSettings:(NSDictionary *)settings {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:settings options:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[NSUbiquitousKeyValueStore defaultStore] setObject:@[jsonString] forKey:[[JSettingsStore instance] keyNameForStore]];
}

@end