#import "BLStore.h"

@class Settings;

@interface SettingsStore : BLStore {
}

- (NSString *)modelName;

- (void) setupDefaults;

@end

