#import "FTOTriumvirateStore.h"
#import "FTOTriumvirate.h"
#import "FTOLiftStore.h"
#import "WorkoutStore.h"
#import "Workout.h"
#import "FTOTriumvirateLift.h"
#import "FTOTriumvirateLiftStore.h"
#import "Set.h"
#import "SetStore.h"

@implementation FTOTriumvirateStore

- (NSArray *)findAll {
    return [[super findAll] sortedArrayUsingComparator:^NSComparisonResult(FTOTriumvirate *t1, FTOTriumvirate *t2) {
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
    FTOTriumvirate *triumvirateLifts = [[FTOTriumvirateStore instance] create];
    triumvirateLifts.mainLift = [[FTOLiftStore instance] find:@"name" value:name];
    triumvirateLifts.workout = [[WorkoutStore instance] create];
    [triumvirateLifts.workout.sets addObjectsFromArray:sets];
}

- (NSArray *)setsForLift:(NSString *)liftName withReps:reps {
    FTOTriumvirateLift *lift = [[FTOTriumvirateLiftStore instance] create];
    lift.name = liftName;
    NSMutableArray *benchSets = [@[] mutableCopy];
    for (int set = 0; set < 5; set++) {
        Set *benchSet = [[SetStore instance] create];
        benchSet.lift = lift;
        benchSet.reps = reps;
        [benchSets addObject:benchSet];
    }
    return benchSets;
}

@end