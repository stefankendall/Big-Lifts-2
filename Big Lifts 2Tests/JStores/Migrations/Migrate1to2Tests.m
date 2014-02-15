#import "Migrate1to2Tests.h"
#import "JSettingsStore.h"
#import "Migrate1to2.h"
#import "JSettings.h"
#import "JVersionStore.h"
#import "JVersion.h"
#import "BLKeyValueStore.h"

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
    NSString *settingsJson = [[BLKeyValueStore store] objectForKey:[[JSettingsStore instance] keyNameForStore]][0];
    NSMutableDictionary *settings = [NSJSONSerialization JSONObjectWithData:[settingsJson dataUsingEncoding:NSUTF8StringEncoding]
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
    STAssertEquals([settings[@"screenAlwaysOn"] intValue], 0, @"");
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

    NSString *settingsJson = [[BLKeyValueStore store] objectForKey:[[JSettingsStore instance] keyNameForStore]][0];
    NSMutableDictionary *settings = [NSJSONSerialization JSONObjectWithData:[settingsJson dataUsingEncoding:NSUTF8StringEncoding]
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];

    STAssertEquals([settings[@"screenAlwaysOn"] intValue], 1, @"");
}

- (void)writeSettings:(NSDictionary *)settings {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:settings options:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[BLKeyValueStore store] setObject:@[jsonString] forKey:[[JSettingsStore instance] keyNameForStore]];
}

@end