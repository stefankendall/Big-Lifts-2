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
    return [self.sets select:^BOOL(JSet *set) {
        return !set.warmup && !set.assistance;
    }];
}

- (NSArray *)warmupSets {
    return [self.sets select:^BOOL(JSet *set) {
        return set.warmup && !set.assistance;
    }];
}

- (NSArray *)assistanceSets {
    return [self.sets select:^BOOL(JSet *set) {
        return set.assistance;
    }];
}

- (void)addSet:(JSet *)set {
    if (set == nil) {
        return;
    }
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
}

- (void)removeSets:(NSArray *)setsToRemove {
    if (setsToRemove == self.sets) {
        for (JSet *set in setsToRemove) {
            [[[BLJStoreManager instance] storeForModel:set.class withUuid:set.uuid] remove:set];
        }
        self.sets = (NSMutableArray <JSet> *) [@[] mutableCopy];
    }
    else {
        for (JSet *set in setsToRemove) {
            [self removeSet:set];
        }
    }
}

- (JLift *)firstLift {
    if ([self.sets count] > 0) {
        return [self.sets[0] lift];
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
}

@end