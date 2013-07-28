#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOLogGraphTransformer.h"
#import "WorkoutLogStore.h"
#import "SetLog.h"
#import "WorkoutLog.h"
#import "OneRepEstimator.h"

@implementation FTOLogGraphTransformer

- (NSArray *)buildDataFromLog {
    NSMutableArray *chartData = [@[] mutableCopy];

    NSEnumerator *log = [[[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"] reverseObjectEnumerator];
    for (WorkoutLog *workoutLog in log) {
        SetLog *bestSetFromWorkout = [self bestSetFromWorkout:workoutLog];
        NSMutableArray *liftLogEntries = [self logEntriesFromChart:chartData forName:bestSetFromWorkout.name];
        [liftLogEntries addObject:[self logToChartEntry:workoutLog withSet:bestSetFromWorkout]];
    }
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

- (NSDictionary *)logToChartEntry:(WorkoutLog *)log withSet:(SetLog *)set {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:log.date];
    NSNumber *year = [NSNumber numberWithInteger:[components year]];
    NSNumber *month = [NSNumber numberWithInteger:[components month]];
    NSNumber *day = [NSNumber numberWithInteger:[components day]];

    return @{
            @"date" : @{
                    @"year" : year,
                    @"month" : month,
                    @"day" : day
            },
            @"weight" : [[OneRepEstimator new] estimate:set.weight withReps:[set.reps intValue]]
    };
}

@end