#import "SSWarmupGenerator.h"
#import "Set.h"
#import "Lift.h"
#import "SetStore.h"

@implementation SSWarmupGenerator

- (void)addWarmup:(Workout *)workout {
    Set *set = workout.sets[0];
    NSArray *warmups = nil;
    if ([set.lift.name isEqualToString:@"Squat"]) {
        warmups = @[
                [[SetStore instance] createWithLift:set.lift percentage:N(0)],
                [[SetStore instance] createWithLift:set.lift percentage:N(0)],
                [[SetStore instance] createWithLift:set.lift percentage:N(40)],
                [[SetStore instance] createWithLift:set.lift percentage:N(60)],
                [[SetStore instance] createWithLift:set.lift percentage:N(80)],
        ];
    }

    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [warmups count])];
    [workout.sets insertObjects:warmups atIndexes:indexes];
}

@end