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
    [self createWorkoutsForVariant:FTO_VARIANT_STANDARD];
    [self removeDuplicates];
}

- (void)dataWasSynced {
    [self removeDuplicates];
}

- (void)removeDuplicates {
    for (FTOCustomWorkout *ftoCustom in [self findAll]) {
        NSArray *allEntries = [self findAllWhere:@"week" value:ftoCustom.week];
        for (int i = 1; i < [allEntries count]; i++) {
            [self remove:allEntries[(NSUInteger) i]];
        }
    }
}

- (void)createWorkoutsForVariant:(NSString *)variant {
    for (int week = 1; week <= 4; week++) {
        [self createWithWorkout:[self createWorkoutForWeek:week variant:variant] week:week order:week];
    }
}

- (Workout *)createWorkoutForWeek:(int)week variant:(NSString *)variant {
    Workout *workout = [[WorkoutStore instance] create];
    NSDictionary *workoutPlan = [[FTOWorkoutSetsGenerator new] setsFor:nil withTemplate:variant];
    NSArray *setData = workoutPlan[[NSNumber numberWithInt:week]];
    NSArray *sets = [setData collect:^id(SetData *data) {
        return [data createSet];
    }];

    [workout addSets:sets];
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

- (void)setupVariant:(NSString *)variant {
    [self empty];
    [self createWorkoutsForVariant:variant];
}

@end