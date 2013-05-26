#import "BLStore.h"

@class Set;

@interface SetLogStore : BLStore
- (id)createFromSet:(Set *)set;
@end