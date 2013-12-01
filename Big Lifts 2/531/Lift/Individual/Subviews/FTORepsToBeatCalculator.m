#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTORepsToBeatCalculator.h"
#import "FTOLift.h"
#import "OneRepEstimator.h"
#import "JFTOSettingsStore.h"
#import "FTOSettings.h"
#import "JWorkoutLog.h"
#import "JWorkoutLogStore.h"
#import "JSetLog.h"
#import "JFTOSettings.h"

@implementation FTORepsToBeatCalculator

- (int)repsToBeat:(JFTOLift *)lift atWeight:(NSDecimalNumber *)weight {
    NSDecimalNumber *max = lift.weight;
    NSDecimalNumber *logMax = [self findLogMax:lift];

    JFTOSettings *ftoSettings = [[JFTOSettingsStore instance] first];
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

- (NSDecimalNumber *)findLogMax:(JFTOLift *)lift {
    NSArray *ftoLogs = [[JWorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"];
    NSArray *ftoLogsForLift = [ftoLogs select:^BOOL(JWorkoutLog *workoutLog) {
        JSetLog *set = [[workoutLog sets] lastObject];
        return [set.name isEqualToString:lift.name];
    }];

    __block NSDecimalNumber *logMax = N(0);
    [ftoLogsForLift each:^(JWorkoutLog *workoutLog) {
        JSetLog *setLog = [[workoutLog sets] lastObject];
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