#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTORepsToBeatCalculator.h"
#import "FTOLift.h"
#import "OneRepEstimator.h"
#import "SetLogStore.h"
#import "SetLog.h"

@implementation FTORepsToBeatCalculator

- (int)repsToBeat:(FTOLift *)lift atWeight:(NSDecimalNumber *)weight {
    __block NSDecimalNumber *max = lift.weight;
    [[[SetLogStore instance] findAllWhere:@"name" value:@"5/3/1"] each:^(SetLog *setLog) {
        NSDecimalNumber *logEstimate = [[OneRepEstimator new] estimate:setLog.weight withReps:[setLog.reps intValue]];
        if ([logEstimate compare:max] == NSOrderedDescending) {
            max = logEstimate;
        }
    }];

    return [self findRepsToBeat:max withWeight:weight];
}

- (int)findRepsToBeat:(NSDecimalNumber *)targetWeight withWeight:(NSDecimalNumber *)weight {
    int reps;
    for (reps = 1; reps < 30; reps++) {
        NSDecimalNumber *estimateMax = [[OneRepEstimator new] estimate:weight withReps:reps];
        NSLog(@"%@ %@", estimateMax, targetWeight);
        if ([estimateMax compare:targetWeight] == NSOrderedDescending) {
            break;
        }
    }

    return reps;
}


@end