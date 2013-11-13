#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTORepsToBeatCalculator.h"
#import "FTOLift.h"
#import "OneRepEstimator.h"
#import "SetLogStore.h"
#import "SetLog.h"
#import "WorkoutLog.h"
#import "WorkoutLogStore.h"
#import "FTOSettingsStore.h"
#import "FTOSettings.h"

@implementation FTORepsToBeatCalculator

- (int)repsToBeat:(FTOLift *)lift atWeight:(NSDecimalNumber *)weight {
    NSDecimalNumber *max = lift.weight;
    NSDecimalNumber *logMax = [self findLogMax:lift];

    FTOSettings *ftoSettings = [[FTOSettingsStore instance] first];
    if ([[ftoSettings repsToBeatConfig] intValue] == kRepsToBeatLogOnly) {
        max = logMax;
    }
    else {
        max = [logMax compare:max] == NSOrderedDescending ? logMax : max;
    }

    if ([max isEqualToNumber:N(0)]) {
        return 0;
    }
    else {
        return [self findRepsToBeat:max withWeight:weight];
    }
}

- (NSDecimalNumber *)findLogMax:(FTOLift *)lift {
    NSArray *ftoLogs = [[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];
    NSArray *ftoLogsForLift = [ftoLogs select:^BOOL(WorkoutLog *workoutLog) {
        SetLog *set = [[workoutLog sets] lastObject];
        return [set.name isEqualToString:lift.name];
    }];

    __block NSDecimalNumber *logMax = N(0);
    [ftoLogsForLift each:^(WorkoutLog *workoutLog) {
        SetLog *setLog = [[workoutLog sets] lastObject];
        NSDecimalNumber *logEstimate = [[OneRepEstimator new] estimate:setLog.weight withReps:[setLog.reps intValue]];
        if ([logEstimate compare:logMax] == NSOrderedDescending) {
            logMax = logEstimate;
        }
    }];
    return logMax;
}

- (int)findRepsToBeat:(NSDecimalNumber *)targetWeight withWeight:(NSDecimalNumber *)weight {
    int reps;
    for (reps = 1; reps < 30; reps++) {
        NSDecimalNumber *estimateMax = [[OneRepEstimator new] estimate:weight withReps:reps];
        if ([estimateMax compare:targetWeight] == NSOrderedDescending) {
            break;
        }
    }

    return reps;
}


@end