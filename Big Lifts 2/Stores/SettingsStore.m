#import "SettingsStore.h"
#import "Settings.h"
#import "BLStoreManager.h"

@implementation SettingsStore

- (void)setupDefaults {
    Settings *settings = [self first];
    if (!settings) {
        Settings *defaultSettings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings" inManagedObjectContext:[BLStoreManager context]];
        [defaultSettings setUnits:@"lbs"];
    }
}

@end