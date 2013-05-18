#import "BLStore.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "ContextManager.h"
#import "SSLiftStore.h"
#import "SSLift.h"

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

- (void)setupWorkoutA:(SSWorkout *)workout {
    SSLift *squat = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Squat"]];
    SSLift *bench = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Bench"]];
    SSLift *deadlift = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Deadlift"]];

    [workout.lifts addObject:squat];
    [workout.lifts addObject:bench];
    [workout.lifts addObject:deadlift];
}

- (void)setupWorkoutB:(SSWorkout *)workout {
    SSLift *squat = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Squat"]];
    SSLift *press = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Press"]];
    SSLift *powerClean = [[SSLiftStore instance] findBy:[NSPredicate predicateWithFormat:@"name == %@", @"Power Clean"]];

    [workout.lifts addObject:squat];
    [workout.lifts addObject:press];
    [workout.lifts addObject:powerClean];
}


@end