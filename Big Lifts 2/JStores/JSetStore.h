#import "BLJStore.h"

@class JSet;

@interface JSetStore : BLJStore
- (JSet *)createFromSet:(JSet *)set;
@end