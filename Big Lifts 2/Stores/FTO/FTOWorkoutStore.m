#import "FTOWorkoutStore.h"
#import "Workout.h"
#import "FTOWorkout.h"
#import "FTOLift.h"
#import "FTOLiftStore.h"
#import "WorkoutStore.h"
#import "FTOWorkoutSetsGenerator.h"
#import "NSArray+Enumerable.h"
#import "SetData.h"
#import "FTOVariant.h"
#import "FTOVariantStore.h"

@implementation FTOWorkoutStore

- (void)setupDefaults {
    [self switchTemplate];
}

- (void)switchTemplate {
    [self empty];
    [self createWorkoutsForEachLift];
    [self markDeloadWorkouts];
}

- (void)markDeloadWorkouts {
    for (NSNumber *week in [[FTOWorkoutSetsGenerator new] deloadWeeks]) {
        [[[FTOWorkoutStore instance] findAllWhere:@"week" value:week] each:^(FTOWorkout *deloadWorkout) {
            deloadWorkout.deload = YES;
        }];
    }
}

- (void)createWorkoutsForEachLift {
    int weeks = 4;

    FTOVariant *variant = [[FTOVariantStore instance] first];
    if ([variant.name isEqualToString:FTO_VARIANT_SIX_WEEK]) {
        weeks = 7;
    }

    for (int week = 1; week <= weeks; week++) {
        [[[FTOLiftStore instance] findAll] each:^(FTOLift *lift) {
            [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:lift week:week] week:week order:[lift.order intValue]];
        }];
    }
}

- (Workout *)createWorkoutForLift:(FTOLift *)lift week:(int)week {
    Workout *workout = [[WorkoutStore instance] create];
    NSArray *setData = [[FTOWorkoutSetsGenerator new] setsForWeek:week lift:lift];
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
    ftoWorkout.order = [NSNumber numberWithInt:order];
}

@end