#import "BLStore.h"

@class Settings;

@interface SettingsStore : BLStore {
}

- (NSString *)modelName;

- (Settings *)settings;

+ (SettingsStore *)instance;
@end

