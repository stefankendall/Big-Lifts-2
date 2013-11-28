#import "BLJStore.h"

@class JSet;
@class JLift;

@interface JSetStore : BLJStore
- (JSet *)createWarmupWithLift:(JLift *)lift percentage:(NSDecimalNumber *)percentage reps:(int)reps;

- (JSet *)createFromSet:(JSet *)set;
@end