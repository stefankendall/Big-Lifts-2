#import "SettingsStore.h"
#import "Settings.h"
#import "ContextManager.h"

@implementation SettingsStore

+ (SettingsStore *)instance {
    static SettingsStore *store = nil;
    if (!store) {
        store = (SettingsStore *) [[super allocWithZone:nil] init];
    }
    return store;
}

- (NSString *)modelName {
    return @"Settings";
}

- (Settings *)first {
    Settings *settings = [super first];
    if (!settings) {
        Settings *defaultSettings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings" inManagedObjectContext:[ContextManager context]];
        [defaultSettings setUnits:@"lbs"];
        return defaultSettings;
    }

    return settings;
}

@end