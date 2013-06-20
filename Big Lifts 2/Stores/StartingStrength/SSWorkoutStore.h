#import "BLStore.h"

@class BLStore;
@class SSWorkout;

@interface SSWorkoutStore : BLStore
- (void)syncSetsToLiftWeights;

- (void)incrementWeights:(SSWorkout *)workout;
@end