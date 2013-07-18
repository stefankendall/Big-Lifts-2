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
    [self createWorkoutsForEachLift];
}

- (void)switchTemplate {
    [self empty];
    [self createWorkoutsForEachLift];
}

- (void)createWorkoutsForEachLift {
    int weeks = 4;

    FTOVariant *variant = [[FTOVariantStore instance] first];
    if([variant.name isEqualToString:FTO_VARIANT_SIX_WEEK]){
        weeks = 7;
    }

    for (int week = 1; week <= weeks; week++) {
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Bench" week:week] week:week order:0];
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Squat" week:week] week:week order:1];
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Deadlift" week:week] week:week order:2];
        [[FTOWorkoutStore instance] createWithWorkout:[self createWorkoutForLift:@"Press" week:week] week:week order:3];
    }
}

- (Workout *)createWorkoutForLift:(NSString *)liftName week:(int)week {
    FTOLift *lift = [[FTOLiftStore instance] find:@"name" value:liftName];

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