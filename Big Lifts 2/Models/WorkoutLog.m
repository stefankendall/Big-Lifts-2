#import <MRCEnumerable/NSArray+Enumerable.h>
#import "WorkoutLog.h"
#import "SetLog.h"
#import "OneRepEstimator.h"

@implementation WorkoutLog

- (NSArray *)orderedSets {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
    return [[self.sets array] sortedArrayUsingDescriptors:@[descriptor]];
}

- (NSArray *)workSets {
    return [self.orderedSets select:^BOOL(SetLog *setLog) {
        return !setLog.warmup && !setLog.assistance;
    }];
}

- (SetLog *)bestSet {
    __block SetLog *bestSet = [self.sets firstObject];
    [self.orderedSets each:^(SetLog *set) {
        NSDecimalNumber *bestMaxEstimate = [[OneRepEstimator new] estimate:bestSet.weight withReps:[bestSet.reps intValue]];
        NSDecimalNumber *maxEstimateForSet = [[OneRepEstimator new] estimate:set.weight withReps:[set.reps intValue]];
        if ([maxEstimateForSet compare:bestMaxEstimate] == NSOrderedDescending) {
            bestSet = set;
        }
    }];
    return bestSet;
}

- (void)addSet:(SetLog *)log {
    NSMutableOrderedSet *newSets = [NSMutableOrderedSet orderedSetWithOrderedSet:self.sets];
    [newSets addObject:log];
    self.sets = newSets;
}

@end