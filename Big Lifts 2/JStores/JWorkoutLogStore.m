#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"

@implementation JWorkoutLogStore

- (Class)modelClass {
    return JWorkoutLog.class;
}

- (void)setDefaultsForObject:(id)object {
    JWorkoutLog *log = object;
    log.sets = [@[] mutableCopy];
}

- (NSArray *)findAll {
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    return [self.data sortedArrayUsingDescriptors:@[sd]];
}

- (JWorkoutLog *)createWithName:(NSString *)name date:(NSDate *)date {
    JWorkoutLog *workoutLog = [self create];
    workoutLog.name = name;
    workoutLog.date = date;
    return workoutLog;
}

@end