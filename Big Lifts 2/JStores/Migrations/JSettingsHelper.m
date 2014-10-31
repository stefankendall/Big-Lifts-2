#import "JSettingsHelper.h"
#import "JSettingsStore.h"

@implementation JSettingsHelper

+ (NSMutableDictionary *)readSettings: (id) store {
    NSArray *settingsValues = [store objectForKey:[[JSettingsStore instance] keyNameForStore]];
    if ([settingsValues count] > 0) {
        NSString *settingsJson = settingsValues[0];
        NSMutableDictionary *settings = [NSJSONSerialization JSONObjectWithData:[settingsJson dataUsingEncoding:NSUTF8StringEncoding]
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:nil];
        return settings;
    }
    return nil;
}

+ (void)writeSettings:(NSDictionary *)settings forStore: (id) store{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:settings options:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [store setObject:@[jsonString] forKey:[[JSettingsStore instance] keyNameForStore]];
}

@end