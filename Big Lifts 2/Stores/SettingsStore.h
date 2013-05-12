#import "BLStore.h"

@class Settings;

@interface SettingsStore : BLStore {
}

- (NSString *)modelName;

+ (SettingsStore *)instance;

- (void) setupDefaults;

@end

