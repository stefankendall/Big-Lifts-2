#import <MRCEnumerable/NSArray+Enumerable.h>
#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import "JFTOWorkoutStore.h"
#import "JFTOWorkout.h"
#import "JFTOAssistanceStore.h"
#import "JFTOSettingsStore.h"
#import "JWorkout.h"
#import "JSet.h"
#import "JFTOVariant.h"
#import "JFTOVariantStore.h"
#import "JFTOLiftStore.h"
#import "JWorkoutStore.h"
#import "JLift.h"
#import "JSetData.h"
#import "JFTOWorkoutSetsGenerator.h"
#import "JFTOPlan.h"
#import "JFTOSettings.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"
#import "JFTOTriumvirateLiftStore.h"

@implementation JFTOWorkoutStore

- (Class)modelClass {
    return JFTOWorkout.class;
}

- (void)onLoad {
    [self fixTriumvirateSets];
}

//delete after a while. This migration would have been painful
- (void)fixTriumvirateSets {
    NSArray *triumvirateLifts = [[JFTOTriumvirateLiftStore instance] findAll];
    for (JFTOWorkout *jftoWorkout in [[JFTOWorkoutStore instance] findAll]) {
        for (JSet *set in jftoWorkout.workout.sets) {
            if ([triumvirateLifts containsObject:set.lift]) {
                set.assistance = YES;
            }
        }
    }
}


- (void)setupDefaults {
    [self switchTemplate];
}

- (void)switchTemplate {
    [self restoreTemplate];
    [[JFTOAssistanceStore instance] addAssistance];
}

- (void)restoreTemplate {
    NSDictionary *doneLiftsByWeek = [self getDoneLiftsByWeek];
    [self removeAll];
    [self createWorkoutsForEachLift];
    [self markDeloadWorkouts];
    [self markWeekIncrements];
    [self remarkDoneLifts:doneLiftsByWeek];
    if (![[[JFTOSettingsStore instance] first] warmupEnabled]) {
        [self removeWarmup];
    }
    [[JFTOFullCustomAssistanceWorkoutStore instance] adjustToFtoWorkouts];
}

- (void)removeWarmup {
    [[[JFTOWorkoutStore instance] findAll] each:^(JFTOWorkout *ftoWorkout) {
        NSArray *warmups = [ftoWorkout.workout.sets select:^BOOL(JSet *set) {
            return set.warmup;
        }];
        [ftoWorkout.workout removeSets:warmups];
    }];
}

- (void)remarkDoneLifts:(NSDictionary *)doneLiftsByWeek {
    [doneLiftsByWeek each:^(NSNumber *week, NSArray *lifts) {
        NSArray *weekWorkouts = [self findAllWhere:@"week" value:week];
        [lifts each:^(JLift *lift) {
            JFTOWorkout *matchingWorkout = [weekWorkouts detect:^BOOL(JFTOWorkout *ftoWorkout) {
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
    [[self findAll] each:^(JFTOWorkout *ftoWorkout) {
        if (ftoWorkout.done) {
            if (!doneLiftsByWeek[ftoWorkout.week]) {
                doneLiftsByWeek[ftoWorkout.week] = [@[] mutableCopy];
            }
            JLift *lift = [[ftoWorkout.workout.sets firstObject] lift];
            if (lift) {
                [doneLiftsByWeek[ftoWorkout.week] addObject:lift];
            }
        }
    }];
    return doneLiftsByWeek;
}

- (void)markDeloadWorkouts {
    for (NSNumber *week in [[JFTOWorkoutSetsGenerator new] deloadWeeks]) {
        [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:week] each:^(JFTOWorkout *deloadWorkout) {
            deloadWorkout.deload = YES;
        }];
    }
}

- (void)markWeekIncrements {
    for (NSNumber *week in [[JFTOWorkoutSetsGenerator new] incrementMaxesWeeks]) {
        [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:week] each:^(JFTOWorkout *ftoWorkout) {
            ftoWorkout.incrementAfterWeek = YES;
        }];
    }
}

- (void)createWorkoutsForEachLift {
    JFTOVariant *variant = [[JFTOVariantStore instance] first];
    NSObject <JFTOPlan> *ftoPlan = [[JFTOWorkoutSetsGenerator new] planForVariant:variant.name];

    if ([[[JFTOSettingsStore instance] first] sixWeekEnabled]) {
        [self createSixWeekWorkouts:ftoPlan];
    }
    else {
        [self createNormalWorkouts:ftoPlan];
    }
}

- (void)createSixWeekWorkouts:(NSObject <JFTOPlan> *)ftoPlan {
    int weeks = [[[ftoPlan generate:nil] allKeys] count];
    NSArray *lifts = [[JFTOLiftStore instance] findAll];
    for (int week = 1; week <= 3; week++) {
        for (int i = 0; i < [lifts count]; i++) {
            JFTOLift *lift = lifts[(NSUInteger) i];
            [self createWithWorkout:[self createWorkoutForLift:lift week:week] week:week order:[lift.order intValue]];
        }
    }

    for (int week = 1; week <= weeks; week++) {
        for (int i = 0; i < [lifts count]; i++) {
            JFTOLift *lift = lifts[(NSUInteger) i];
            [self createWithWorkout:[self createWorkoutForLift:lift week:week] week:(week + 3) order:[lift.order intValue]];
        }
    }
}

- (void)createNormalWorkouts:(NSObject <JFTOPlan> *)ftoPlan {
    int weeks = [[[ftoPlan generate:nil] allKeys] count];
    NSArray *lifts = [[JFTOLiftStore instance] findAll];
    for (int week = 1; week <= weeks; week++) {
        for (int i = 0; i < [lifts count]; i++) {
            JFTOLift *lift = lifts[(NSUInteger) i];
            [self createWithWorkout:[self createWorkoutForLift:lift week:week] week:week order:[lift.order intValue]];
        }
    }
}

- (JWorkout *)createWorkoutForLift:(JFTOLift *)lift week:(int)week {
    JWorkout *workout = [[JWorkoutStore instance] create];
    NSArray *setData = [[JFTOWorkoutSetsGenerator new] setsForWeek:week lift:lift];
    NSArray *sets = [setData collect:^id(JSetData *data) {
        return [data createSet];
    }];

    [workout addSets:sets];
    return workout;
}

- (void)createWithWorkout:(id)workout week:(int)week order:(int)order {
    JFTOWorkout *ftoWorkout = [self create];
    ftoWorkout.workout = workout;
    ftoWorkout.week = [NSNumber numberWithInt:week];
    ftoWorkout.order = [NSNumber numberWithInt:order];
}

- (void)reorderWorkoutsToLifts {
    NSArray *workouts = [self findAll];
    for (JFTOWorkout *workout in workouts) {
        if ([workout.workout.sets count] > 0) {
            JLift *lift = [workout.workout.sets[0] lift];
            workout.order = lift.order;
        }
    }
}

@end