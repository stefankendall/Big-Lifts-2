#import "JSettingsHelper.h"
#import "BLKeyValueStore.h"
#import "JSettingsStore.h"

@implementation JSettingsHelper

+ (NSMutableDictionary *)readSettings {
    NSArray *settingsValues = [[BLKeyValueStore store] objectForKey:[[JSettingsStore instance] keyNameForStore]];
    if ([settingsValues count] > 0) {
        NSString *settingsJson = settingsValues[0];
        NSMutableDictionary *settings = [NSJSONSerialization JSONObjectWithData:[settingsJson dataUsingEncoding:NSUTF8StringEncoding]
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:nil];
        return settings;
    }
    return nil;
}

+ (void)writeSettings:(NSDictionary *)settings {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:settings options:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[BLKeyValueStore store] setObject:@[jsonString] forKey:[[JSettingsStore instance] keyNameForStore]];
}

@end