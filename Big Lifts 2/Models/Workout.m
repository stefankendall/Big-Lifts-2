#import <MRCEnumerable/NSArray+Enumerable.h>
#import "Workout.h"
#import "Set.h"
#import "Lift.h"

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
    int order = [self.sets count];
    set.workout = self;
    set.order = [NSNumber numberWithInt:order];
    [newSets addObject:set];
    self.sets = newSets;
}

- (void)addSets:(NSArray *)newSets {
    for (Set *set in newSets) {
        [self addSet:set];
    }
}

- (void)removeSet:(Set *)set {
    [self.sets removeObject:set];
    [self fixSetOrdering];
}

- (void)removeSets:(NSArray *)sets {
    for (Set *set in sets) {
        [self removeSet:set];
    }
}

- (void)fixSetOrdering {
    [[self orderedSets] eachWithIndex:^(Set *set, NSUInteger index) {
        set.order = [NSNumber numberWithInt:index];
    }];
}

- (NSArray *)orderedSets {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
    return [[self.sets array] sortedArrayUsingDescriptors:@[descriptor]];
}

- (Lift *)firstLift {
    if ([self.sets count] > 0) {
        return [self.sets[0] lift];
    }
    return nil;
}


@end