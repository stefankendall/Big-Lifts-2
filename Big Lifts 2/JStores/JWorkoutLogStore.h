#import "BLJStore.h"
#import "BLJBackedUpStore.h"

@class JWorkoutLog;

@interface JWorkoutLogStore : BLJBackedUpStore
- (JWorkoutLog *)createWithName:(NSString *)name date:(NSDate *)date;
@end