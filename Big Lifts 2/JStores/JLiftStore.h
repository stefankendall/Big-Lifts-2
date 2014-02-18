#import "BLJStore.h"

@class JLift;

@interface JLiftStore : BLJStore

- (void)copy:(JLift *)source into:(JLift *)dest;

@end