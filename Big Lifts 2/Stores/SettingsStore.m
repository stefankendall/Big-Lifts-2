#import "SettingsStore.h"
#import "Settings.h"
#import "ContextManager.h"

@implementation SettingsStore

+ (SettingsStore *)instance {
    static SettingsStore *store = nil;
    if (!store) {
        store = (SettingsStore *) [[super allocWithZone:nil] init];
        [store setupDefaults];
    }
    return store;
}

- (void)setupDefaults {
    Settings *settings = [self first];
    if (!settings) {
        Settings *defaultSettings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings" inManagedObjectContext:[ContextManager context]];
        [defaultSettings setUnits:@"lbs"];
    }
}

- (NSString *)modelName {
    return @"Settings";
}

@end