#import "JFTOTriumvirateStore.h"
#import "JFTOTriumvirate.h"
#import "JLift.h"
#import "JFTOLiftStore.h"
#import "JWorkoutStore.h"
#import "JWorkout.h"
#import "JFTOTriumvirateLiftStore.h"
#import "JFTOTriumvirateLift.h"
#import "JSetStore.h"
#import "JSet.h"

@implementation JFTOTriumvirateStore

- (Class)modelClass {
    return JFTOTriumvirate.class;
}

- (NSArray *)findAll {
    return [self.data sortedArrayUsingComparator:^NSComparisonResult(JFTOTriumvirate *t1, JFTOTriumvirate *t2) {
        return [t1.mainLift.order compare:t2.mainLift.order];
    }];
}

- (void)setupDefaults {
    [self setupLiftsFor:@"Bench" withSets:[self benchSets]];
    [self setupLiftsFor:@"Squat" withSets:[self squatSets]];
    [self setupLiftsFor:@"Deadlift" withSets:[self deadliftSets]];
    [self setupLiftsFor:@"Press" withSets:[self pressSets]];
}

- (NSArray *)squatSets {
    return [[self setsForLift:@"Leg Press" withReps:@15]
            arrayByAddingObjectsFromArray:
                    [self setsForLift:@"Leg Curl" withReps:@10]];
}

- (NSArray *)pressSets {
    return [[self setsForLift:@"Dips" withReps:@15]
            arrayByAddingObjectsFromArray:
                    [self setsForLift:@"Chin-ups" withReps:@10]];
}

- (NSArray *)deadliftSets {
    return [[self setsForLift:@"Good Morning" withReps:@12]
            arrayByAddingObjectsFromArray:
                    [self setsForLift:@"Hanging Leg Raise" withReps:@15]];
}

- (NSArray *)benchSets {
    return [[self setsForLift:@"Dumbbell Bench" withReps:@15]
            arrayByAddingObjectsFromArray:
                    [self setsForLift:@"Dumbbell Row" withReps:@10]];
}

- (void)setupLiftsFor:(NSString *)name withSets:(NSArray *)sets {
    JFTOTriumvirate *triumvirateLifts = [[JFTOTriumvirateStore instance] create];
    triumvirateLifts.mainLift = [[JFTOLiftStore instance] find:@"name" value:name];
    triumvirateLifts.workout = [[JWorkoutStore instance] create];
    [triumvirateLifts.workout addSets:sets];
}

- (NSArray *)setsForLift:(NSString *)liftName withReps:reps {
    JFTOTriumvirateLift *lift = [[JFTOTriumvirateLiftStore instance] create];
    lift.name = liftName;
    NSMutableArray *sets = [@[] mutableCopy];
    for (int setCount = 0; setCount < 5; setCount++) {
        JSet *set = [[JSetStore instance] create];
        set.lift = lift;
        set.reps = reps;
        set.assistance = YES;
        [sets addObject:set];
    }
    return sets;
}

@end