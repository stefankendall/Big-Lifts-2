#import "JSSWorkoutStore.h"
#import "JSSStateStore.h"
#import "JSSState.h"
#import "JSSVariant.h"
#import "JSSVariantStore.h"
#import "JSSLiftStore.h"
#import "JSSLift.h"
#import "JWorkoutStore.h"
#import "JWorkout.h"
#import "JSetStore.h"
#import "JSSWorkout.h"
#import "JSet.h"
#import "NSArray+Enumerable.h"
#import "JSSWarmupGenerator.h"

@implementation JSSWorkoutStore

- (void)setupDefaults {
    [self setupVariant:@"Standard"];
}

- (void)setupVariant:(NSString *)variant {
    JSSVariant *variantObj = [[JSSVariantStore instance] first];
    variantObj.name = variant;

    [self empty];

    JSSWorkout *workoutA = [[JSSWorkoutStore instance] createWithName:@"A" withOrder:0 withAlternation:0];
    JSSWorkout *workoutB = [[JSSWorkoutStore instance] createWithName:@"B" withOrder:1 withAlternation:0];

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
        JSSWorkout *workoutA2 = [[JSSWorkoutStore instance] createWithName:@"A" withOrder:0.5 withAlternation:1];
        [self setupStandardB:workoutA2];
        [self setupOnusWunslerB:workoutB];
    }
    else if ([variant isEqualToString:@"Practical Programming"]) {
        [self restrictLiftsTo:@[@"Squat", @"Press", @"Bench", @"Deadlift", @"Press", @"Chin-ups", @"Pull-ups"]];
        [self removeBar:@[@"Chin-ups", @"Pull-ups"]];

        [self setupPracticalAMonday:workoutA];
        JSSWorkout *workoutA1Press = [[JSSWorkoutStore instance] createWithName:@"A" withOrder:0.25 withAlternation:0];
        [self setupPracticalAMonday:workoutA1Press];
        [self replaceBenchWithPress:workoutA1Press];

        JSSWorkout *workoutA2 = [[JSSWorkoutStore instance] createWithName:@"A" withOrder:0.5 withAlternation:1];
        JSSWorkout *workoutA2Press = [[JSSWorkoutStore instance] createWithName:@"A" withOrder:0.7 withAlternation:1];
        [self setupPracticalAFriday:workoutA2];
        [self setupPracticalAFriday:workoutA2Press];
        [self replaceBenchWithPress:workoutA2Press];

        JSSWorkout *workoutBPress = [[JSSWorkoutStore instance] createWithName:@"B" withOrder:1.2 withAlternation:1];
        [self setupPracticalBWednesday:workoutB];
        [self setupPracticalBWednesday:workoutBPress];
        [self replaceBenchWithPress:workoutBPress];
    }
}

- (void)replaceBenchWithPress:(JSSWorkout *)w {
    [w.workouts replaceObjectAtIndex:1 withObject:[self      createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Press"] withSets:3 withReps:5]];
}

- (void)removeBar:(NSArray *)lifts {
    for (NSString *liftName in lifts) {
        JSSLift *lift = [[JSSLiftStore instance] find:@"name" value:liftName];
        lift.usesBar = NO;
    }
}

- (void)setupPracticalBWednesday:(JSSWorkout *)w {
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Bench"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                 createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Deadlift"] withSets:1 withReps:5]];
}

- (void)setupPracticalAFriday:(JSSWorkout *)w {
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Bench"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                 createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Pull-ups"] withSets:3 withReps:-1 amrap:YES]];
}

- (void)setupPracticalAMonday:(JSSWorkout *)w {
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Bench"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                 createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Chin-ups"] withSets:3 withReps:-1 amrap:YES]];
}

- (void)addWarmup {
    [[[JSSWorkoutStore instance] findAll] each:^(JSSWorkout *ssWorkout) {
        [ssWorkout.workouts each:^(JWorkout *workout) {
            [[JSSWarmupGenerator new] addWarmup:workout];
        }];
    }];
}

- (void)removeWarmup {
    [[[JSSWorkoutStore instance] findAll] each:^(JSSWorkout *ssWorkout) {
        [ssWorkout.workouts each:^(JWorkout *workout) {
            [[JSSWarmupGenerator new] removeWarmup:workout];
        }];
    }];
}

- (void)restrictLiftsTo:(NSArray *)liftNames {
    [[JSSLiftStore instance] addMissingLifts:liftNames];
    [[JSSLiftStore instance] removeExtraLifts:liftNames];
}

- (void)setupOnusWunslerB:(JSSWorkout *)w {
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Bench"] withSets:3 withReps:5]];
    [w.workouts addObject:[self createWorkout:[[JSSLiftStore instance] find:@"name" value:@"Back Extension"]
                                     withSets:3 withReps:10]];
}

- (void)setupNoviceB:(JSSWorkout *)w {
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Press"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                 createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Deadlift"] withSets:1 withReps:5]];
}

- (void)setupStandardA:(JSSWorkout *)w {
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Bench"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                 createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Deadlift"] withSets:1 withReps:5]];
}

- (void)setupStandardB:(JSSWorkout *)w {
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Squat"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                              createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Press"] withSets:3 withReps:5]];
    [w.workouts addObject:[self                                    createWorkout:
            [[JSSLiftStore instance] find:@"name" value:@"Power Clean"] withSets:5 withReps:3]];
}

- (JWorkout *)createWorkout:(JSSLift *)lift withSets:(int)sets withReps:(int)reps {
    JWorkout *workout = [[JWorkoutStore instance] create];

    for (int i = 0; i < sets; i++) {
        JSet *set = [[JSetStore instance] create];
        set.lift = lift;
        set.reps = [NSNumber numberWithInt:reps];
        set.percentage = N(100);
        [workout addSet:set];
    }

    return workout;
}

- (JWorkout *)createWorkout:(JSSLift *)lift withSets:(int)sets withReps:(int)reps amrap:(BOOL)amrap {
    JWorkout *workout = [self createWorkout:lift withSets:sets withReps:reps];
    [workout.orderedSets each:^(JSet *set) {
        set.amrap = amrap;
    }];
    return workout;
}

- (void)incrementWeights:(JSSWorkout *)ssWorkout {
    for (JWorkout *workout in ssWorkout.workouts) {
        JSet *firstSet = workout.orderedSets[0];
        JSSLift *lift = (JSSLift *) firstSet.lift;
        if (lift.increment) {
            lift.weight = [lift.weight decimalNumberByAdding:lift.increment];
        }
    }
}

- (JSSWorkout *)createWithName:(NSString *)name withOrder:(double)order withAlternation:(int)alternation {
    JSSWorkout *workout = [self create];
    workout.name = name;
    workout.order = [NSNumber numberWithDouble:order];
    workout.alternation = [NSNumber numberWithInt:alternation];
    return workout;
}

- (JSSWorkout *)activeWorkoutFor:(NSString *)name {
    NSArray *ssWorkouts = [[JSSWorkoutStore instance] findAllWhere:@"name" value:name];
    JSSVariant *variant = [[JSSVariantStore instance] first];
    if ([[variant name] isEqualToString:@"Practical Programming"]) {
        ssWorkouts = [self filterToAlternateBenchOrPress:ssWorkouts];
    }

    JSSState *state = [[JSSStateStore instance] first];
    JSSWorkout *newSsWorkout = ssWorkouts[0];
    if ([name isEqualToString:@"A"] && [ssWorkouts count] > 0) {
        int workoutAAlteration = [state.workoutAAlternation intValue];
        NSArray *alt1Workouts = [ssWorkouts select:^BOOL(JSSWorkout *ssWorkout) {
            return [ssWorkout.alternation intValue] == workoutAAlteration;
        }];

        if ([alt1Workouts count] > 0) {
            newSsWorkout = alt1Workouts[0];
        }
    }

    return newSsWorkout;
}

- (NSArray *)filterToAlternateBenchOrPress:(NSArray *)ssWorkouts {
    JSSState *state = [[JSSStateStore instance] first];
    JWorkout *workout = [state.lastWorkout.workouts detect:^BOOL(JWorkout *workout1) {
        JSet *lastSet = [workout1.orderedSets lastObject];
        return [lastSet.lift.name isEqualToString:@"Bench"] ||
                [lastSet.lift.name isEqualToString:@"Press"];
    }];
    JSet *set = [workout.orderedSets lastObject];
    NSString *nextLift = [set.lift.name isEqualToString:@"Bench"] ? @"Press" : @"Bench";

    return [ssWorkouts select:^BOOL(JSSWorkout *ssWorkout) {
        return [ssWorkout.workouts detect:^BOOL(JWorkout *workout1) {
            JSet *set1 = [workout1.orderedSets lastObject];
            return [set1.lift.name isEqualToString:nextLift];
        }] != nil;
    }];
}

@end