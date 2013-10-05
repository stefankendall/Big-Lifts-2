#import "BLStore.h"

@class Set;

@interface SetLogStore : BLStore
- (id)createFromSet:(Set *)set;

- (id)createWithName:(NSString *)name weight:(NSDecimalNumber *)weight reps:(int)reps warmup:(BOOL)warmup assistance:(BOOL)assistance amrap:(BOOL)amrap;
@end