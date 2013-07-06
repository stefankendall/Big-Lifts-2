#import "SSWarmupGenerator.h"
#import "Set.h"
#import "Lift.h"
#import "SetStore.h"

@implementation SSWarmupGenerator

- (void)addWarmup:(Workout *)workout {
    Set *set = workout.sets[0];
    NSDictionary *warmups = @{
            @"Squat" : @[
                    [[SetStore instance] createWithLift:set.lift percentage:N(0)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(0)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(40)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(60)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(80)],
            ],
            @"Bench" : @[
                    [[SetStore instance] createWithLift:set.lift percentage:N(0)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(0)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(50)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(70)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(90)],
            ],
            @"Deadlift" : @[
                    [[SetStore instance] createWithLift:set.lift percentage:N(40)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(40)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(60)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(85)]
            ],
            @"Press" : @[
                    [[SetStore instance] createWithLift:set.lift percentage:N(0)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(0)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(55)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(70)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(85)],
            ],
            @"Power Clean" : @[
                    [[SetStore instance] createWithLift:set.lift percentage:N(0)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(0)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(55)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(70)],
                    [[SetStore instance] createWithLift:set.lift percentage:N(85)],
            ]
    };

    NSArray *warmup = warmups[set.lift.name];
    if (warmup) {
        NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [warmup count])];
        [workout.sets insertObjects:warmup atIndexes:indexes];
    }
}

@end