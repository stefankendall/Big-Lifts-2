#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JWorkout.h"
#import "JLift.h"
#import "JSet.h"
#import "BLJStoreManager.h"
#import "BLJStore.h"

@implementation JWorkout

- (NSArray *)cascadeDeleteProperties {
    return @[@"sets"];
}

- (NSArray *)workSets {
    return [self.orderedSets select:^BOOL(JSet *set) {
        return !set.warmup && !set.assistance;
    }];
}

- (NSArray *)warmupSets {
    return [self.orderedSets select:^BOOL(JSet *set) {
        return set.warmup && !set.assistance;
    }];
}

- (NSArray *)assistanceSets {
    return [self.orderedSets select:^BOOL(JSet *set) {
        return set.assistance;
    }];
}

- (void)addSet:(JSet *)set {
    int order = [self.sets count];
    set.order = [NSNumber numberWithInt:order];
    [self.sets addObject:set];
}

- (void)addSets:(NSArray *)newSets {
    for (JSet *set in newSets) {
        [self addSet:set];
    }
}

- (void)removeSet:(JSet *)set {
    [self.sets removeObject:set];
    [[[BLJStoreManager instance] storeForModel:set.class withUuid:set.uuid] remove:set];
    [self fixSetOrdering];
}

- (void)removeSets:(NSArray *)sets {
    for (JSet *set in sets) {
        [self removeSet:set];
    }
}

- (void)fixSetOrdering {
    [[self orderedSets] eachWithIndex:^(JSet *set, NSUInteger index) {
        set.order = [NSNumber numberWithInt:index];
    }];
}

- (NSArray *)orderedSets {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
    return [self.sets sortedArrayUsingDescriptors:@[descriptor]];
}

- (JLift *)firstLift {
    if ([self.orderedSets count] > 0) {
        return [self.orderedSets[0] lift];
    }
    return nil;
}

- (void)addSets:(NSArray *)sets atIndex:(int)index {
    if (index != 0) {
        [NSException raise:NSInvalidArgumentException
                    format:@"Not supported"];
    }
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [sets count])];
    [self.sets insertObjects:sets atIndexes:indexes];
    int order = -1;
    for (JSet *set in [sets reverseObjectEnumerator]) {
        set.order = [NSNumber numberWithInt:order--];
    }
    [self fixSetOrdering];
}

@end