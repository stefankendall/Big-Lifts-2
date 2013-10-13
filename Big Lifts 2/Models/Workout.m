#import <MRCEnumerable/NSArray+Enumerable.h>
#import "Workout.h"
#import "Set.h"

@implementation Workout

- (NSArray *)workSets {
    return [[self.sets array] select:^BOOL(Set *set) {
        return !set.warmup && !set.assistance;
    }];
}

- (NSArray *)warmupSets {
    return [[self.sets array] select:^BOOL(Set *set) {
        return set.warmup && !set.assistance;
    }];
}

- (NSArray *)assistanceSets {
    return [[self.sets array] select:^BOOL(Set *set) {
        return set.assistance;
    }];
}

//Core Data bug
//http://stackoverflow.com/questions/7385439/exception-thrown-in-nsorderedset-generated-accessors/7922993#7922993
- (void)addSet:(Set *)set {
    NSMutableOrderedSet *newSets = [NSMutableOrderedSet orderedSetWithOrderedSet:self.sets];
    set.workout = self;
    [newSets addObject:set];
    self.sets = newSets;
}

- (void)addSets:(NSArray *)newSets {
    for (Set *set in newSets) {
        [self addSet:set];
    }
}

@end