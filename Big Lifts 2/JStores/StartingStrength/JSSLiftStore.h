#import "BLJStore.h"
#import "JLiftStore.h"

@interface JSSLiftStore : JLiftStore
- (void)adjustForKg;

- (void)addMissingLifts:(NSArray *)liftNames;

- (void)removeExtraLifts:(NSArray *)liftNames;
@end