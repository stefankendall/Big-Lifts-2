#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JWorkoutLog.h"
#import "JSetLog.h"
#import "OneRepEstimator.h"

@implementation JWorkoutLog

- (NSArray *)cascadeDeleteProperties {
    return @[@"sets"];
}

- (NSArray *)workSets {
    return [self.sets select:^BOOL(JSetLog *setLog) {
        return !setLog.warmup && !setLog.assistance;
    }];
}

- (JSetLog *)bestSet {
    __block JSetLog *bestSet = [self.workSets firstObject];
    [self.workSets each:^(JSetLog *set) {
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