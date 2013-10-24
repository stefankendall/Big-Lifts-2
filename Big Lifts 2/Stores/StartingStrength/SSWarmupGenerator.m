#import <MRCEnumerable/NSArray+Enumerable.h>
#import "SSWarmupGenerator.h"
#import "Set.h"
#import "Lift.h"
#import "SetStore.h"

@implementation SSWarmupGenerator

- (void)addWarmup:(Workout *)workout {
    Set *set = workout.orderedSets[0];
    NSDictionary *warmups = @{
            @"Squat" : @[
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(0)  reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(0)  reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(40) reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(60) reps:3],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(80) reps:2],
            ],
            @"Bench" : @[
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(50)reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(70)reps:3],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(90)reps:2],
            ],
            @"Deadlift" : @[
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(40)reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(40)reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(60)reps:3],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(85)reps:2]
            ],
            @"Press" : @[
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(55)reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(70)reps:3],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(85)reps:2],
            ],
            @"Power Clean" : @[
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(55)reps:5],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(70)reps:3],
                    [[SetStore instance] createWarmupWithLift:set.lift percentage:N(85)reps:2],
            ]
    };

    NSArray *warmup = warmups[set.lift.name];
    if (warmup) {
        [workout addSets:warmup atIndex: 0];
    }
}

- (void)removeWarmup:(Workout *)workout {
    NSArray *warmupSets = [workout.orderedSets select:(BOOL (^)(id)) ^(Set *set) {
        return set.warmup;
    }];
    [workout removeSets:warmupSets];
}

@end