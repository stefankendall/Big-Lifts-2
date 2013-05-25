#import "SettingsStore.h"
#import "Settings.h"
#import "ContextManager.h"

@implementation SettingsStore

- (void)setupDefaults {
    Settings *settings = [self first];
    if (!settings) {
        Settings *defaultSettings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings" inManagedObjectContext:[ContextManager context]];
        [defaultSettings setUnits:@"lbs"];
    }
}

@end