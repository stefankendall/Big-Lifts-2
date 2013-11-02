#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "Lift.h"
#import "SetLog.h"

@implementation WorkoutLogStore

- (WorkoutLog *)createWithName:(NSString *)name date:(NSDate *)date {
    WorkoutLog *workoutLog = [self create];
    workoutLog.name = name;
    workoutLog.date = date;
    return workoutLog;
}

- (void)onLoad {
    [self correctEmptyOrderOnSets];
}

- (void)correctEmptyOrderOnSets {
    NSArray *allWorkouts = [self findAll];
    for (WorkoutLog *workoutLog in allWorkouts) {
        if ([[workoutLog.orderedSets firstObject] order] == nil ) {
            int count = 0;
            for (SetLog *set in workoutLog.orderedSets) {
                set.order = [NSNumber numberWithInt:count++];
            }
        }
    }
}

- (NSArray *)findAll {
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    return [super findAllWithSort:sd];
}

@end