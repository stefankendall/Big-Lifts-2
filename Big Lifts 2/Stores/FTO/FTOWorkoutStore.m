#import "FTOWorkoutStore.h"
#import "Workout.h"
#import "FTOWorkout.h"
#import "FTOLift.h"
#import "FTOLiftStore.h"
#import "Set.h"
#import "SetStore.h"
#import "WorkoutStore.h"

@implementation FTOWorkoutStore

- (void)setupDefaults {
    for (int week = 1; week <= 4; week++) {
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Bench" week:week] week:week];
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Squat" week:week] week:week];
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Deadlift" week:week] week:week];
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Press" week:week] week:week];
    }
}

- (Workout *)createWorkoutForLift:(NSString *)liftName week:(int)week {
    FTOLift *lift = [[FTOLiftStore instance] find:@"name" value:liftName];
    Set *fakeSet = [[SetStore instance] create];
    fakeSet.weight = [NSDecimalNumber decimalNumberWithString:@"0"];
    fakeSet.reps = [NSDecimalNumber decimalNumberWithString:@"0"];
    fakeSet.lift = lift;

    Workout *workout = [[WorkoutStore instance] create];
    [workout.sets addObject:fakeSet];
    return workout;
}

- (void)createWithWorkout:(Workout *)workout week:(int)week {
    FTOWorkout *ftoWorkout = [self create];
    ftoWorkout.workout = workout;
    ftoWorkout.week = [NSNumber numberWithInt:week];
}

@end