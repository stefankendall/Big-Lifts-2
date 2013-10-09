#import "FTOCustomWorkoutStore.h"
#import "FTOLift.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "SetData.h"
#import "NSArray+Enumerable.h"
#import "FTOWorkoutSetsGenerator.h"
#import "WorkoutStore.h"
#import "FTOVariant.h"
#import "FTOCustomWorkout.h"

@implementation FTOCustomWorkoutStore

- (void)setupDefaults {
    [self createWorkoutsForEachLift];
}

- (void)createWorkoutsForEachLift {
    for (int week = 1; week <= 4; week++) {
        [self createWithWorkout:[self createWorkoutForWeek:week] week:week order:week];
    }
}

- (Workout *)createWorkoutForWeek:(int)week {
    Workout *workout = [[WorkoutStore instance] create];
    NSDictionary *workoutPlan = [[FTOWorkoutSetsGenerator new] setsFor:nil withTemplate:FTO_VARIANT_STANDARD];
    NSArray *setData = workoutPlan[[NSNumber numberWithInt:week]];
    NSArray *sets = [setData collect:^id(SetData *data) {
        return [data createSet];
    }];

    [workout.sets addObjectsFromArray:sets];
    return workout;
}

- (void)createWithWorkout:(id)workout week:(int)week order:(int)order {
    FTOCustomWorkout *customWorkout = [self create];
    customWorkout.workout = workout;
    customWorkout.week = [NSNumber numberWithInt:week];
    customWorkout.order = [NSNumber numberWithInt:order];
    customWorkout.name = @{@1 : @"5/5/5", @2 : @"3/3/3", @3 : @"5/3/1", @4 : @"Deload"}[[NSNumber numberWithInt:week]];
}

- (void)reorderWeeks {
    for (int week = 1; week < [[FTOCustomWorkoutStore instance] count]; week++) {
        FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] atIndex:week];
        customWorkout.week = [NSNumber numberWithInt:week];
        customWorkout.order = [NSNumber numberWithInt:week];
    }
}

@end