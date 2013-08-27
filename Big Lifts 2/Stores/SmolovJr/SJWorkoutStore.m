#import "SJWorkoutStore.h"
#import "SJWorkout.h"
#import "WorkoutStore.h"
#import "SetStore.h"
#import "Set.h"
#import "SJLiftStore.h"
#import "SJLift.h"
#import "Workout.h"

@implementation SJWorkoutStore

- (void)setupDefaults {
    [self createWorkoutInWeek:1 order:1 sets:6 reps:6 percentage:N(70) minWeightAdd:0 maxWeightAdd:0];
    [self createWorkoutInWeek:1 order:2 sets:7 reps:5 percentage:N(75) minWeightAdd:0 maxWeightAdd:0];
    [self createWorkoutInWeek:1 order:3 sets:8 reps:4 percentage:N(80) minWeightAdd:0 maxWeightAdd:0];
    [self createWorkoutInWeek:1 order:4 sets:10 reps:3 percentage:N(85) minWeightAdd:0 maxWeightAdd:0];

    [self createWorkoutInWeek: 2 order: 5 sets: 6 reps: 6 percentage: N(70) minWeightAdd: 10 maxWeightAdd: 20];
    [self createWorkoutInWeek: 2 order: 6 sets: 7 reps: 5 percentage: N(75) minWeightAdd: 10 maxWeightAdd: 20];
    [self createWorkoutInWeek: 2 order: 7 sets: 8 reps: 4 percentage: N(80) minWeightAdd: 10 maxWeightAdd: 20];
    [self createWorkoutInWeek: 2 order: 8 sets: 10 reps: 3 percentage: N(85) minWeightAdd: 10 maxWeightAdd: 20];

    [self createWorkoutInWeek: 3 order: 9 sets: 6 reps: 6 percentage: N(70) minWeightAdd: 15 maxWeightAdd: 25];
    [self createWorkoutInWeek: 3 order: 10 sets: 7 reps: 5 percentage: N(75) minWeightAdd: 15 maxWeightAdd: 25];
    [self createWorkoutInWeek: 3 order: 11 sets: 8 reps: 4 percentage: N(80) minWeightAdd: 15 maxWeightAdd: 25];
    [self createWorkoutInWeek: 3 order: 12 sets: 10 reps: 3 percentage: N(85) minWeightAdd: 15 maxWeightAdd: 25];
}

- (void)createWorkoutInWeek:(int)week order:(int)order sets:(int)sets reps:(int)reps percentage:(NSDecimalNumber *)percentage minWeightAdd:(int)minWeightAdd maxWeightAdd:(int)maxWeightAdd {
    SJWorkout *sjWorkout = [[SJWorkoutStore instance] create];
    sjWorkout.done = NO;
    sjWorkout.week = [NSNumber numberWithInt:week];
    sjWorkout.order = [NSNumber numberWithInt:order];
    sjWorkout.minWeightAdd = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:minWeightAdd] decimalValue]];
    sjWorkout.maxWeightAdd = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:maxWeightAdd] decimalValue]];
    Workout *workout = [[WorkoutStore instance] create];

    SJLift *lift = [[SJLiftStore instance] first];
    for( int setCount = 0; setCount < sets; setCount++ ){
        Set *set = [[SetStore instance] create];
        set.lift = lift;
        set.percentage = percentage;
        set.reps = [NSNumber numberWithInt:reps];
        [workout.sets addObject: set];
    }

    sjWorkout.workout = workout;
}

@end