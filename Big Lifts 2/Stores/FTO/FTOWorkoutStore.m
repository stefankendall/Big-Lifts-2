#import "FTOWorkoutStore.h"
#import "Workout.h"
#import "FTOWorkout.h"
#import "FTOLift.h"
#import "FTOLiftStore.h"
#import "Set.h"
#import "SetStore.h"
#import "WorkoutStore.h"
#import "FTOWorkoutSetsGenerator.h"
#import "NSArray+Enumerable.h"
#import "SetData.h"

@implementation FTOWorkoutStore

- (void)setupDefaults {
    for (int week = 1; week <= 4; week++) {
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Bench" week:week] week:week order: 0];
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Squat" week:week] week:week order:1];
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Deadlift" week:week] week:week order:2];
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Press" week:week] week:week order:3];
    }
}

- (Workout *)createWorkoutForLift:(NSString *)liftName week:(int)week {
    FTOLift *lift = [[FTOLiftStore instance] find:@"name" value:liftName];
    Set *fakeSet = [[SetStore instance] create];
    fakeSet.weight = [NSDecimalNumber decimalNumberWithString:@"0"];
    fakeSet.reps = [NSDecimalNumber decimalNumberWithString:@"0"];
    fakeSet.lift = lift;

    Workout *workout = [[WorkoutStore instance] create];
    NSArray *setData = [[FTOWorkoutSetsGenerator new] setsForWeek:week lift: lift];
    NSArray *sets = [setData collect:^id(SetData *data) {
        return [data createSet];
    }];
    [workout.sets addObjectsFromArray:sets];
    return workout;
}

- (void)createWithWorkout:(id)workout week:(int)week order:(int)order {
    FTOWorkout *ftoWorkout = [self create];
    ftoWorkout.workout = workout;
    ftoWorkout.week = [NSNumber numberWithInt:week];
    ftoWorkout.order = [NSNumber numberWithInt: order];
}

@end