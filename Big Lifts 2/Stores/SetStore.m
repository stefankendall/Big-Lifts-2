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

@end