#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLog.h"
#import "NSArray+Enumerable.h"

@implementation WorkoutLogStore

- (WorkoutLog *)createWithName:(NSString *)name date:(NSDate *)date {
    WorkoutLog *workoutLog = [self create];
    workoutLog.name = name;
    workoutLog.date = date;
    return workoutLog;
}

- (void)onLoad {
    [self correctEmptyOrderOnSets];
    [self fixUnorderedStartingStrengthLogs];
}

- (void)fixUnorderedStartingStrengthLogs {
    NSArray *workoutLogs = [[WorkoutLogStore instance] findAllWhere:@"name" value:@"Starting Strength"];
    for (WorkoutLog *workoutLog in workoutLogs) {
        NSSet *orders = [[NSSet alloc] initWithArray:[workoutLog.orderedSets collect:^(SetLog *setLog) {
            return setLog.order;
        }]];
        if ([orders count] != [[workoutLog orderedSets] count]) {
            [self fixStartingStrengthWorkoutLogOrder:workoutLog];
        }
    }
}

- (void)fixStartingStrengthWorkoutLogOrder:(WorkoutLog *)workoutLog {
    NSSet *liftNames = [[NSSet alloc] initWithArray:[workoutLog.orderedSets collect:^id(SetLog *setLog) {
        return setLog.name;
    }]];
    NSArray *orderedLiftNames = [[liftNames allObjects] sortedArrayUsingSelector:@selector(compare:)];
    int order = 0;
    for (NSString *lift in orderedLiftNames) {
        NSArray *sameLiftSets = [workoutLog.orderedSets select:^BOOL(SetLog *setLog) {
            return [setLog.name isEqualToString:lift];
        }];
        for (SetLog *setLog in sameLiftSets) {
            setLog.order = [NSNumber numberWithInt:order++];
        }
    }

    NSSet *orders = [[NSSet alloc] initWithArray:[workoutLog.orderedSets collect:^(SetLog *setLog) {
        return setLog.order;
    }]];
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