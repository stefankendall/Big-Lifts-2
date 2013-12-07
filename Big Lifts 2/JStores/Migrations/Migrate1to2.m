#import "Migrate1to2.h"
#import "JSettingsStore.h"

@implementation Migrate1to2

- (void)run {
    NSString *storeKey = [[JSettingsStore instance] keyNameForStore];
    NSArray *settingsData = [[NSUbiquitousKeyValueStore defaultStore] arrayForKey:storeKey];
    NSString *settingsJson = settingsData[0];
    NSMutableDictionary *settings = [NSJSONSerialization JSONObjectWithData:[settingsJson dataUsingEncoding:NSUTF8StringEncoding]
                                                             options:NSJSONReadingMutableContainers
                                                               error:nil];
    settings[@"screenAlwaysOn"] = @0;

    NSString *jsonString = [[NSString alloc] initWithData:
            [NSJSONSerialization dataWithJSONObject:settings options:nil error:nil] encoding:NSUTF8StringEncoding];

    [[NSUbiquitousKeyValueStore defaultStore] setArray:@[jsonString] forKey:storeKey];
}

@end