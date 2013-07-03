#import "BLStore.h"

@class Settings;

@interface SettingsStore : BLStore {
}

- (void)adjustForKg;

- (NSDecimalNumber *)defaultIncrementForLift:(NSString *)liftName;

- (NSDecimalNumber *)defaultLbsIncrementForLift:(NSString *)liftName;
@end

