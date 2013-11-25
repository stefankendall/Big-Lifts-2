#import "BLJStore.h"

@interface JSettingsStore : BLJStore
- (void)adjustForKg;

- (NSDecimalNumber *)defaultIncrementForLift:(NSString *)liftName;

- (NSDecimalNumber *)defaultLbsIncrementForLift:(NSString *)liftName;
@end