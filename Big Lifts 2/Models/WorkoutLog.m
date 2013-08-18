#import <MRCEnumerable/NSArray+Enumerable.h>
#import "WorkoutLog.h"
#import "SetLog.h"
#import "OneRepEstimator.h"

@implementation WorkoutLog
- (NSArray *)workSets {
    return [[self.sets array] select:^BOOL(SetLog *setLog) {
        return !setLog.warmup && !setLog.assistance;
    }];
}

- (SetLog *)bestSet {
    __block SetLog *bestSet = [self.sets firstObject];
    [[self.sets array] each:^(SetLog *set) {
        NSDecimalNumber *bestMaxEstimate = [[OneRepEstimator new] estimate:bestSet.weight withReps:[bestSet.reps intValue]];
        NSDecimalNumber *maxEstimateForSet = [[OneRepEstimator new] estimate:set.weight withReps:[set.reps intValue]];
        if ([maxEstimateForSet compare:bestMaxEstimate] == NSOrderedDescending) {
            bestSet = set;
        }
    }];
    return bestSet;
}

@end