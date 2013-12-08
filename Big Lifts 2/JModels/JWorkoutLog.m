#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JWorkoutLog.h"
#import "JSetLog.h"
#import "OneRepEstimator.h"

@implementation JWorkoutLog

- (NSArray *)cascadeDeleteClasses {
    return @[JSetLog.class];
}

- (NSArray *)orderedSets {
    return self.sets;
}

- (NSArray *)workSets {
    return [self.orderedSets select:^BOOL(JSetLog *setLog) {
        return !setLog.warmup && !setLog.assistance;
    }];
}

- (JSetLog *)bestSet {
    __block JSetLog *bestSet = [self.orderedSets firstObject];
    [self.orderedSets each:^(JSetLog *set) {
        NSDecimalNumber *bestMaxEstimate = [[OneRepEstimator new] estimate:bestSet.weight withReps:[bestSet.reps intValue]];
        NSDecimalNumber *maxEstimateForSet = [[OneRepEstimator new] estimate:set.weight withReps:[set.reps intValue]];
        if ([maxEstimateForSet compare:bestMaxEstimate] == NSOrderedDescending) {
            bestSet = set;
        }
    }];
    return bestSet;
}

- (void)addSet:(JSetLog *)log {
    [self.sets addObject:log];
}

@end