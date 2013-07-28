#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOLogGraphTransformer.h"
#import "WorkoutLogStore.h"
#import "SetLog.h"
#import "WorkoutLog.h"
#import "OneRepEstimator.h"

@implementation FTOLogGraphTransformer

- (NSArray *)buildDataFromLog {
    NSMutableArray *chartData = [@[] mutableCopy];

    [[[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"] each:^(WorkoutLog *workoutLog) {
        SetLog *bestSetFromWorkout = [self bestSetFromWorkout:workoutLog];
        NSMutableArray *liftLogEntries = [self logEntriesFromChart:chartData forName:bestSetFromWorkout.name];
    }];

    return chartData;
}

- (NSMutableArray *)logEntriesFromChart:(NSMutableArray *)chartData forName:(NSString *)name {
    NSMutableDictionary *existingLiftData = [chartData detect:^BOOL(NSMutableDictionary *liftData) {
        return [liftData[@"name"] isEqualToString:name];
    }];

    if (!existingLiftData) {
        existingLiftData = [@{@"name" : name, @"data" : [@[] mutableCopy]} mutableCopy];
        [chartData addObject:existingLiftData];
    }

    return existingLiftData[@"data"];
}

- (SetLog *)bestSetFromWorkout:(WorkoutLog *)log {
    __block SetLog *bestSet = [log.sets firstObject];
    [[log.sets array] each:^(SetLog *set) {
        NSDecimalNumber *bestMaxEstimate = [[OneRepEstimator new] estimate:bestSet.weight withReps:[bestSet.reps intValue]];
        NSDecimalNumber *maxEstimateForSet = [[OneRepEstimator new] estimate:set.weight withReps:[set.reps intValue]];
        if ([maxEstimateForSet compare:bestMaxEstimate] == NSOrderedDescending) {
            bestSet = set;
        }
    }];
    return bestSet;
}

@end