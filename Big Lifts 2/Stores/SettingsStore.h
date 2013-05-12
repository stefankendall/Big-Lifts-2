#import "BLStore.h"

@class Settings;

@interface SettingsStore : BLStore {
}

- (NSString *)modelName;

+ (SettingsStore *)instance;
@end

