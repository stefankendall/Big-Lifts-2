#import "BLStore.h"

@class Set;
@class SSLift;
@class Lift;

@interface SetStore : BLStore

- (Set *)createWithLift:(Lift *)lift percentage:(NSDecimalNumber *)percentage;

- (Set *)createWarmupWithLift:(Lift *)lift percentage:(NSDecimalNumber *)percentage reps:(int)reps;
@end