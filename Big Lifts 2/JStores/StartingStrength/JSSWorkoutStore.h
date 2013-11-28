#import "BLJStore.h"

@class JSSWorkout;

@interface JSSWorkoutStore : BLJStore
- (void)setupVariant:(NSString *)variant;

- (void)replaceBenchWithPress:(JSSWorkout *)w;

- (void)addWarmup;

- (void)incrementWeights:(JSSWorkout *)ssWorkout;

- (JSSWorkout *)activeWorkoutFor:(NSString *)name;
@end