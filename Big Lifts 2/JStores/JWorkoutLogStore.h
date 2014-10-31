#import "BLJStore.h"

@class JWorkoutLog;

@interface JWorkoutLogStore : BLJStore
- (JWorkoutLog *)createWithName:(NSString *)name date:(NSDate *)date;
@end