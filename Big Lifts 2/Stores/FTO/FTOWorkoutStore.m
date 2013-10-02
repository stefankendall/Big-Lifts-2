#import <MRCEnumerable/NSDictionary+Enumerable.h>
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
#import "FTOCustomWorkoutStore.h"
#import "FTOAssistanceStore.h"

@implementation FTOWorkoutStore

- (void)setupDefaults {
    [self switchTemplate];
}

- (void)switchTemplate {
    [self restoreTemplate];
    [[FTOAssistanceStore instance] addAssistance];
}

- (void)restoreTemplate {
    NSDictionary *doneLiftsByWeek = [self getDoneLiftsByWeek];
    [self empty];
    [self createWorkoutsForEachLift];
    [self markDeloadWorkouts];
    [self remarkDoneLifts:doneLiftsByWeek];
}

- (void)remarkDoneLifts:(NSDictionary *)doneLiftsByWeek {
    [doneLiftsByWeek each:^(NSNumber *week, NSArray *lifts) {
        NSArray *weekWorkouts = [self findAllWhere:@"week" value:week];
        [lifts each:^(Lift *lift) {
            FTOWorkout *matchingWorkout = [weekWorkouts detect:^BOOL(FTOWorkout *ftoWorkout) {
                return [[ftoWorkout.workout.sets firstObject] lift] == lift;
            }];
            if (matchingWorkout) {
                matchingWorkout.done = YES;
            }
        }];
    }];
}

- (NSDictionary *)getDoneLiftsByWeek {
    NSMutableDictionary *doneLiftsByWeek = [@{} mutableCopy];
    [[self findAll] each:^(FTOWorkout *ftoWorkout) {
        if (ftoWorkout.done) {
            if (!doneLiftsByWeek[ftoWorkout.week]) {
                doneLiftsByWeek[ftoWorkout.week] = [@[] mutableCopy];
            }
            Lift *lift = [[ftoWorkout.workout.sets firstObject] lift];
            [doneLiftsByWeek[ftoWorkout.week] addObject:lift];
        }
    }];
    return doneLiftsByWeek;
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
    else if ([variant.name isEqualToString:FTO_VARIANT_CUSTOM]) {
        weeks = [[FTOCustomWorkoutStore instance] count];
    }

    NSArray *lifts = [[FTOLiftStore instance] findAll];
    for (int week = 1; week <= weeks; week++) {
        for (int i = 0; i < [lifts count]; i++) {
            FTOLift *lift = lifts[(NSUInteger) i];
            [self createWithWorkout:[self createWorkoutForLift:lift week:week] week:week order:[lift.order intValue]];
        }
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

- (void)reorderWorkoutsToLifts {
    NSArray *workouts = [self findAll];
    for (FTOWorkout *workout in workouts) {
        if ([workout.workout.sets count] > 0) {
            Lift *lift = [workout.workout.sets[0] lift];
            workout.order = lift.order;
        }
    }
}
@end