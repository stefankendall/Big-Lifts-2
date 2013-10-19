#import "SetStore.h"
#import "Set.h"
#import "SSLift.h"
#import "Lift.h"

@implementation SetStore
- (Set *)createWithLift:(Lift *)lift percentage:(NSDecimalNumber *)percentage {
    Set *set = [[SetStore instance] create];
    set.lift = lift;
    set.percentage = percentage;
    return set;
}

- (Set *)createWarmupWithLift:(Lift *)lift percentage:(NSDecimalNumber *)percentage reps: (int) reps{
    Set *set = [[SetStore instance] createWithLift:lift percentage:percentage];
    set.warmup = YES;
    set.reps = [NSNumber numberWithInt:reps];
    return set;
}

- (Set *)createFromSet:(Set *)set {
    Set *newSet = [[SetStore instance] create];
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

@end