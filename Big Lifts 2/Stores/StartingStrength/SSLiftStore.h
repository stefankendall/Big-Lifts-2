#import "BLStore.h"

@interface SSLiftStore : BLStore
- (void)adjustForKg;

- (void)addMissingLifts:(NSArray *)array;

- (void)removeExtraLifts:(NSArray *)array;

@end