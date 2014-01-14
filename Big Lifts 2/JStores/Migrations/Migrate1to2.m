#import "Migrate1to2.h"
#import "JSettingsStore.h"
#import "BLKeyValueStore.h"

@implementation Migrate1to2

- (void)run {
    [self addScreenAlwaysOnToSettings];
}

- (void)addScreenAlwaysOnToSettings {
    NSString *storeKey = [[JSettingsStore instance] keyNameForStore];
    NSArray *settingsData = [[BLKeyValueStore store] arrayForKey:storeKey];
    if([settingsData count] == 0){
        return;
    }

    NSString *settingsJson = settingsData[0];
    NSMutableDictionary *settings = [NSJSONSerialization JSONObjectWithData:[settingsJson dataUsingEncoding:NSUTF8StringEncoding]
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
    if (![settings objectForKey:@"screenAlwaysOn"]) {
        settings[@"screenAlwaysOn"] = @0;
    }

    NSString *jsonString = [[NSString alloc]                                    initWithData:
            [NSJSONSerialization dataWithJSONObject:settings options:nil error:nil] encoding:NSUTF8StringEncoding];

    [[BLKeyValueStore store] setArray:@[jsonString] forKey:storeKey];
}

@end