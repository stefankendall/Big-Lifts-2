#import "BLJStore.h"
#import "BLJBackedUpStore.h"

@class JSet;

@interface JSetLogStore : BLJBackedUpStore
- (id)createFromSet:(JSet *)set;

- (id)createWithName:(NSString *)name weight:(NSDecimalNumber *)weight reps:(int)reps warmup:(BOOL)warmup assistance:(BOOL)assistance amrap:(BOOL)amrap;
@end