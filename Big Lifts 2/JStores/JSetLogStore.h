#import "BLJStore.h"

@class JSet;

@interface JSetLogStore : BLJStore
- (id)createFromSet:(JSet *)set;

- (id)createWithName:(NSString *)name weight:(NSDecimalNumber *)weight reps:(int)reps warmup:(BOOL)warmup assistance:(BOOL)assistance amrap:(BOOL)amrap order:(int)order;
@end