#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOLogGraphTransformer.h"
#import "OneRepEstimator.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSetLog.h"

@implementation FTOLogGraphTransformer

- (NSArray *)buildDataFromLog {
    NSMutableArray *chartData = [@[] mutableCopy];

    NSArray *allLogs = [[JWorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];
    NSArray *noDeload = [allLogs select:^BOOL(JWorkoutLog *workoutLog) {
        return !workoutLog.deload;
    }];
    for (JWorkoutLog *workoutLog in [noDeload reverseObjectEnumerator]) {
        JSetLog *bestSetFromWorkout = [workoutLog bestSet];
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

- (NSDictionary *)logToChartEntry:(JWorkoutLog *)log withSet:(JSetLog *)set {
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