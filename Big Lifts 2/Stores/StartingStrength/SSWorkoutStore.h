#import "BLStore.h"

@class BLStore;
@class SSWorkout;

@interface SSWorkoutStore : BLStore
- (void)setupVariant:(NSString *)variant;

- (void)syncSetsToLiftWeights;

- (void)incrementWeights:(SSWorkout *)workout;
@end