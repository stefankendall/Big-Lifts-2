#import "BLStore.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "ContextManager.h"
#import "SSLiftStore.h"
#import "SSLift.h"
#import "Set.h"
#import "Workout.h"
#import "SetStore.h"
#import "WorkoutStore.h"

@implementation SSWorkoutStore

- (NSString *)modelName {
    return @"SSWorkout";
}

- (void)setupDefaults {
    if ([self count] == 0) {
        SSWorkout *workoutA = [NSEntityDescription insertNewObjectForEntityForName:[self modelName] inManagedObjectContext:[ContextManager context]];
        [workoutA setName:@"A"];
        [workoutA setOrder:[NSNumber numberWithDouble:0.0]];
        [self setupWorkoutA:workoutA];

        SSWorkout *workoutB = [NSEntityDescription insertNewObjectForEntityForName:[self modelName] inManagedObjectContext:[ContextManager context]];
        [workoutB setName:@"B"];
        [workoutB setOrder:[NSNumber numberWithDouble:1.0]];
        [self setupWorkoutB:workoutB];
    }
}

- (void)setupWorkoutA:(SSWorkout *)ssWorkout {
    SSLift *squat = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Squat"]];
    SSLift *bench = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Bench"]];
    SSLift *deadlift = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Deadlift"]];

    [ssWorkout.workouts addObject:[self createWorkout:squat withSets:3 withReps:5]];
    [ssWorkout.workouts addObject:[self createWorkout:bench withSets:3 withReps:5]];
    [ssWorkout.workouts addObject:[self createWorkout:deadlift withSets:1 withReps:5]];
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

- (void)setupWorkoutB:(SSWorkout *)ssWorkout {
    SSLift *squat = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Squat"]];
    SSLift *press = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Press"]];
    SSLift *powerClean = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Power Clean"]];

    [ssWorkout.workouts addObject:[self createWorkout:squat withSets:3 withReps:5]];
    [ssWorkout.workouts addObject:[self createWorkout:press withSets:3 withReps:5]];
    [ssWorkout.workouts addObject:[self createWorkout:powerClean withSets:5 withReps:3]];
}


@end