#import "BLJStore.h"

@interface JSSLiftStore : BLJStore
- (void)addMissingLifts:(NSArray *)liftNames;

- (void)removeExtraLifts:(NSArray *)liftNames;
@end