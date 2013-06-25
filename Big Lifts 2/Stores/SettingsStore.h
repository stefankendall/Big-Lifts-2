#import "BLStore.h"

@class Settings;

@interface SettingsStore : BLStore {
}

- (NSDecimalNumber *)defaultIncrementForLift:(NSString *)liftName;

- (NSDecimalNumber *)defaultLbsIncrementForLift:(NSString *)liftName;
@end

