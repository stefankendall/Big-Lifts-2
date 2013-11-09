#import "BLStore.h"

@class WorkoutLog;

@interface WorkoutLogStore : BLStore

- (WorkoutLog *)createWithName:(NSString *)name date:(NSDate *)date;

- (void)fixUnorderedStartingStrengthLogs;
@end