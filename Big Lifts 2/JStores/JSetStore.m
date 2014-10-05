#import "JSetStore.h"
#import "JSet.h"
#import "JLift.h"

@implementation JSetStore

- (Class)modelClass {
    return JSet.class;
}

- (void)setDefaultsForObject:(id)object {
    JSet *set = object;
    set.percentage = N(100);
}

- (JSet *)createWithLift:(JLift *)lift percentage:(NSDecimalNumber *)percentage {
    JSet *set = [self create];
    set.lift = lift;
    set.percentage = percentage;
    return set;
}

- (JSet *)createWarmupWithLift:(JLift *)lift percentage:(NSDecimalNumber *)percentage reps:(int)reps {
    JSet *set = [self createWithLift:lift percentage:percentage];
    set.warmup = YES;
    set.reps = [NSNumber numberWithInt:reps];
    return set;
}

- (JSet *)createFromSet:(JSet *)set {
    JSet *newSet = [self create];
    newSet.reps = set.reps;
    newSet.maxReps = set.maxReps;
    newSet.percentage = set.percentage;
    newSet.lift = set.lift;
    newSet.warmup = set.warmup;
    newSet.amrap = set.amrap;
    newSet.optional = set.optional;
    newSet.assistance = set.assistance;
    return newSet;
}

- (void)adjustToLifts {
    NSMutableArray *deadSets = [@[] mutableCopy];
    for (JSet *set in self.data) {
        if ([set.lift isDead]) {
            [deadSets addObject:set];
        }
    }
    for (JSet *deadSet in deadSets) {
        [self remove:deadSet];
    }
}
@end