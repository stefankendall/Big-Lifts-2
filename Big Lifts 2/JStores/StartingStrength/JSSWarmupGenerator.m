#import "JSSWarmupGenerator.h"
#import "JWorkout.h"
#import "JSetStore.h"
#import "JSet.h"
#import "JLift.h"
#import "NSArray+Enumerable.h"

@implementation JSSWarmupGenerator

- (void)addWarmup:(JWorkout *)workout {
    JSet *set = workout.orderedSets[0];
    NSDictionary *warmups = @{
            @"Squat" : @[
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(0)  reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(0)  reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(40) reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(60) reps:3],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(80) reps:2],
            ],
            @"Bench" : @[
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(50)reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(70)reps:3],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(90)reps:2],
            ],
            @"Deadlift" : @[
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(40)reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(40)reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(60)reps:3],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(85)reps:2]
            ],
            @"Press" : @[
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(55)reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(70)reps:3],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(85)reps:2],
            ],
            @"Power Clean" : @[
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(0) reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(55)reps:5],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(70)reps:3],
                    [[JSetStore instance] createWarmupWithLift:set.lift percentage:N(85)reps:2],
            ]
    };

    NSArray *warmup = warmups[set.lift.name];
    if (warmup) {
        [workout addSets:warmup atIndex:0];
    }
}

- (void)removeWarmup:(JWorkout *)workout {
    NSArray *warmupSets = [workout.orderedSets select:(BOOL (^)(id)) ^(JSet *set) {
        return set.warmup;
    }];
    [workout removeSets:warmupSets];
}

@end