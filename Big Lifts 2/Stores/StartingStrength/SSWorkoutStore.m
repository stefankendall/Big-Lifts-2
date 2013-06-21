#import "BLStore.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "SSLiftStore.h"
#import "SSLift.h"
#import "Set.h"
#import "Workout.h"
#import "SetStore.h"
#import "WorkoutStore.h"

@implementation SSWorkoutStore

- (void)setupDefaults {
    if ([self count] == 0) {
        [self setupVariant:@"Standard"];
    }
}

- (void)setupVariant:(NSString *)variant {
    [self empty];

    SSWorkout *workoutA = [[SSWorkoutStore instance] create];
    [workoutA setName:@"A"];
    [workoutA setOrder:[NSNumber numberWithDouble:0.0]];
    SSWorkout *workoutB = [[SSWorkoutStore instance] create];
    [workoutB setName:@"B"];
    [workoutB setOrder:[NSNumber numberWithDouble:1.0]];

    if ([variant isEqualToString:@"Standard"]) {
        [self setupStandardA:workoutA];
        [self setupStandardB:workoutB];
    }
    else {
        [self setupStandardA:workoutA];
        [self setupNoviceB:workoutB];
    }
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
        [workout.sets addObject:set];
    }

    return workout;
}

- (void)onLoad {
    [self syncSetsToLiftWeights];

    [[SSLiftStore instance] registerChangeListener:^{
        [self syncSetsToLiftWeights];
    }];
}

- (void)syncSetsToLiftWeights {
    NSArray *ssWorkouts = [[SSWorkoutStore instance] findAll];
    for (SSWorkout *ssWorkout in ssWorkouts) {
        for (Workout *workout in ssWorkout.workouts) {
            for (Set *set in workout.sets) {
                SSLift *lift = (SSLift *) set.lift;
                set.weight = lift.weight;
            }
        }
    }
}

- (void)incrementWeights:(SSWorkout *)ssWorkout {
    for (Workout *workout in ssWorkout.workouts) {
        Set *firstSet = workout.sets[0];
        SSLift *lift = (SSLift *) firstSet.lift;
        lift.weight = [lift.weight decimalNumberByAdding:lift.increment];
    }
}

@end