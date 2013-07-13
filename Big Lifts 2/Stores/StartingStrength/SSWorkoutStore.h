#import "BLStore.h"

@class BLStore;
@class SSWorkout;

@interface SSWorkoutStore : BLStore
- (void)setupVariant:(NSString *)variant;

- (void)replaceBenchWithPress:(SSWorkout *)workout;

- (void)setupWarmup;

- (void)incrementWeights:(SSWorkout *)workout;

- (SSWorkout *)createWithName:(NSString *)string withOrder:(double)order withAlternation:(int)alternation;

- (SSWorkout *)activeWorkoutFor:(NSString *)name;
@end