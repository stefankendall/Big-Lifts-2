#import "BLStore.h"

@interface FTOLiftStore : BLStore
- (BOOL)orderingBroken;

- (void)incrementLifts;

- (void)adjustForKg;
@end