#import <MRCEnumerable/NSArray+Enumerable.h>
#import "Workout.h"
#import "Set.h"

@implementation Workout

- (NSArray *)workSets {
    return [[self.sets array] select:^BOOL(Set *set) {
        return !set.warmup && !set.assistance;
    }];
}

//Core Data bug
//http://stackoverflow.com/questions/7385439/exception-thrown-in-nsorderedset-generated-accessors/7922993#7922993
- (void)addSet:(Set *)set {
    NSMutableOrderedSet *newSets = [NSMutableOrderedSet orderedSetWithOrderedSet:self.sets];
    [newSets addObject:set];
    self.sets = newSets;
}

@end