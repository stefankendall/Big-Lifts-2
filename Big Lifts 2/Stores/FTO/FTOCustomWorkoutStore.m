#import "FTOCustomWorkoutStore.h"
#import "FTOLiftStore.h"
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
        [[[FTOLiftStore instance] findAll] each:^(FTOLift *lift) {
            [self createWithWorkout:[self createWorkoutForLift:lift week:week] week:week order:[lift.order intValue]];
        }];
    }
}

- (Workout *)createWorkoutForLift:(FTOLift *)lift week:(int)week {
    Workout *workout = [[WorkoutStore instance] create];
    NSDictionary *workoutPlan = [[FTOWorkoutSetsGenerator new] setsFor:lift withTemplate:FTO_VARIANT_STANDARD];
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
}

@end