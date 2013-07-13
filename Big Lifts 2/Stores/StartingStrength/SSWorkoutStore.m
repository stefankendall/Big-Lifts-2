#import <MRCEnumerable/NSArray+Enumerable.h>
#import "BLStore.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "SSLiftStore.h"
#import "SSLift.h"
#import "Set.h"
#import "Workout.h"
#import "SetStore.h"
#import "WorkoutStore.h"
#import "SSVariantStore.h"
#import "SSVariant.h"
#import "SSWarmupGenerator.h"
#import "SSStateStore.h"
#import "SSState.h"

@implementation SSWorkoutStore

- (void)setupDefaults {
    if ([self count] == 0) {
        [self setupVariant:@"Standard"];
    }
}

- (void)setupVariant:(NSString *)variant {
    SSVariant *variantObj = [[SSVariantStore instance] first];
    variantObj.name = variant;

    [self empty];

    SSWorkout *workoutA = [[SSWorkoutStore instance] createWithName:@"A" withOrder:0 withAlternation:0];
    SSWorkout *workoutB = [[SSWorkoutStore instance] createWithName:@"B" withOrder:1 withAlternation:0];

    if ([variant isEqualToString:@"Standard"]) {
        [self restrictLiftsTo:@[@"Press", @"Bench", @"Power Clean", @"Deadlift", @"Squat"]];
        [self setupStandardA:workoutA];
        [self setupStandardB:workoutB];
    }
    else if ([variant isEqualToString:@"Novice"]) {
        [self restrictLiftsTo:@[@"Press", @"Bench", @"Deadlift", @"Squat"]];
        [self setupStandardA:workoutA];
        [self setupNoviceB:workoutB];
    } else if ([variant isEqualToString:@"Onus-Wunsler"]) {
        [self restrictLiftsTo:@[@"Press", @"Bench", @"Power Clean", @"Deadlift", @"Squat", @"Back Extension"]];
        [self removeBar:@[@"Back Extension"]];
        [self setupNoviceB:workoutA];
        SSWorkout *workoutA2 = [[SSWorkoutStore instance] createWithName:@"A" withOrder:0.5 withAlternation:1];
        [self setupStandardB:workoutA2];
        [self setupOnusWunslerB:workoutB];
    }
    else if ([variant isEqualToString:@"Practical Programming"]) {
        [self restrictLiftsTo:@[@"Squat", @"Press", @"Bench", @"Deadlift", @"Press", @"Chin-ups", @"Pull-ups"]];
        [self removeBar:@[@"Chin-ups", @"Pull-ups"]];

        [self setupPracticalAMonday:workoutA];
        SSWorkout *workoutA1Press = [[SSWorkoutStore instance] createWithName:@"A" withOrder:0.25 withAlternation:0];
        [self setupPracticalAMonday:workoutA1Press];
        [self replaceBenchWithPress:workoutA1Press];

        SSWorkout *workoutA2 = [[SSWorkoutStore instance] createWithName:@"A" withOrder:0.5 withAlternation:1];
        SSWorkout *workoutA2Press = [[SSWorkoutStore instance] createWithName:@"A" withOrder:0.7 withAlternation:1];
        [self setupPracticalAFriday:workoutA2];
        [self setupPracticalAFriday:workoutA2Press];
        [self replaceBenchWithPress:workoutA2Press];

        SSWorkout *workoutBPress = [[SSWorkoutStore instance] createWithName:@"B" withOrder:1.2 withAlternation:1];
        [self setupPracticalBWednesday:workoutB];
        [self setupPracticalBWednesday:workoutBPress];
        [self replaceBenchWithPress:workoutBPress];
    }

    [self setupWarmup];
}

- (void)replaceBenchWithPress:(SSWorkout *)w {
    [w.workouts replaceObjectAtIndex:1 withObject:[self     createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Press"] withSets:3 withReps:5]];
}

- (void)removeBar:(NSArray *)lifts {
    for (NSString *liftName in lifts) {
        SSLift *lift = [[SSLiftStore instance] find:@"name" value:liftName];
        lift.usesBar = NO;
    }
}

- (void)setupPracticalBWednesday:(SSWorkout *)w {
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Bench"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Deadlift"] withSets:1 withReps:5]];
}

- (void)setupPracticalAFriday:(SSWorkout *)w {
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Bench"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Pull-ups"] withSets:3 withReps:-1 amrap:YES]];
}

- (void)setupPracticalAMonday:(SSWorkout *)w {
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Bench"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Chin-ups"] withSets:3 withReps:-1 amrap:YES]];
}

- (void)setupWarmup {
    [[[SSWorkoutStore instance] findAll] each:^(SSWorkout *ssWorkout) {
        [[ssWorkout.workouts array] each:^(Workout *workout) {
            [[SSWarmupGenerator new] addWarmup:workout];
        }];
    }];
}

- (void)restrictLiftsTo:(NSArray *)liftNames {
    [[SSLiftStore instance] addMissingLifts:liftNames];
    [[SSLiftStore instance] removeExtraLifts:liftNames];
}

- (void)setupOnusWunslerB:(SSWorkout *)w {
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Bench"] withSets:3 withReps:5]];
    [w.workouts addObject:[self createWorkout:[[SSLiftStore instance] find:@"name" value:@"Back Extension"]
                                     withSets:3 withReps:10]];
}

- (void)setupNoviceB:(SSWorkout *)w {
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Press"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Deadlift"] withSets:1 withReps:5]];
}

- (void)setupStandardA:(SSWorkout *)w {
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Bench"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Deadlift"] withSets:1 withReps:5]];
}

- (void)setupStandardB:(SSWorkout *)w {
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                             createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Press"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                   createWorkout:
            [[SSLiftStore instance] find:@"name" value:@"Power Clean"] withSets:5 withReps:3]];
}

- (Workout *)createWorkout:(SSLift *)lift withSets:(int)sets withReps:(int)reps {
    Workout *workout = [[WorkoutStore instance] create];

    for (int i = 0; i < sets; i++) {
        Set *set = [[SetStore instance] create];
        set.lift = lift;
        set.reps = [NSNumber numberWithInt:reps];
        set.percentage = N(100);
        [workout.sets addObject:set];
    }

    return workout;
}

- (Workout *)createWorkout:(SSLift *)lift withSets:(int)sets withReps:(int)reps amrap:(BOOL)amrap {
    Workout *workout = [self createWorkout:lift withSets:sets withReps:reps];
    [[workout.sets array] each:^(Set *set) {
        set.amrap = amrap;
    }];
    return workout;
}

- (void)incrementWeights:(SSWorkout *)ssWorkout {
    for (Workout *workout in ssWorkout.workouts) {
        Set *firstSet = workout.sets[0];
        SSLift *lift = (SSLift *) firstSet.lift;
        if (lift.increment) {
            lift.weight = [lift.weight decimalNumberByAdding:lift.increment];
        }
    }
}

- (SSWorkout *)createWithName:(NSString *)name withOrder:(double)order withAlternation:(int)alternation {
    SSWorkout *workout = [self create];
    workout.name = name;
    workout.order = [NSNumber numberWithDouble:order];
    workout.alternation = [NSNumber numberWithInt:alternation];
    return workout;
}

- (SSWorkout *)activeWorkoutFor:(NSString *)name {
    NSArray *ssWorkouts = [[SSWorkoutStore instance] findAllWhere:@"name" value:name];
    SSVariant *variant = [[SSVariantStore instance] first];
    if ([[variant name] isEqualToString:@"Practical Programming"]) {
        ssWorkouts = [self filterToAlternateBenchOrPress:ssWorkouts];
    }

    SSState *state = [[SSStateStore instance] first];
    SSWorkout *newSsWorkout = ssWorkouts[0];
    if ([name isEqualToString:@"A"] && [ssWorkouts count] > 0) {
        int workoutAAlteration = [state.workoutAAlternation intValue];
        NSArray *alt1Workouts = [ssWorkouts select:^BOOL(SSWorkout *ssWorkout) {
            return [ssWorkout.alternation intValue] == workoutAAlteration;
        }];

        newSsWorkout = alt1Workouts[0];
    }

    return newSsWorkout;
}

- (NSArray *)filterToAlternateBenchOrPress:(NSArray *)ssWorkouts {
    SSState *state = [[SSStateStore instance] first];
    Workout *workout = [[state.lastWorkout.workouts array] detect:^BOOL(Workout *workout1) {
        Set *lastSet = [workout1.sets lastObject];
        return [lastSet.lift.name isEqualToString:@"Bench"] ||
                [lastSet.lift.name isEqualToString:@"Press"];
    }];
    Set *set = [workout.sets lastObject];
    NSString *nextLift = [set.lift.name isEqualToString:@"Bench"] ? @"Press" : @"Bench";

    return [ssWorkouts select:^BOOL(SSWorkout *ssWorkout) {
        return [[ssWorkout.workouts array] detect:^BOOL(Workout *workout1) {
            Set *set1 = [workout1.sets lastObject];
            return [set1.lift.name isEqualToString:nextLift];
        }] != nil;
    }];
}

@end