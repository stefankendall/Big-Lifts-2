#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOLogGraphTransformer.h"
#import "WorkoutLogStore.h"
#import "SetLog.h"
#import "WorkoutLog.h"
#import "OneRepEstimator.h"

@implementation FTOLogGraphTransformer

- (NSArray *)buildDataFromLog {
    NSMutableArray *chartData = [@[] mutableCopy];

    NSArray *allLogs = [[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];
    NSArray *noDeload = [allLogs select:^BOOL(WorkoutLog *workoutLog) {
        return !workoutLog.deload;
    }];
    for (WorkoutLog *workoutLog in [noDeload reverseObjectEnumerator]) {
        SetLog *bestSetFromWorkout = [workoutLog bestSet];
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