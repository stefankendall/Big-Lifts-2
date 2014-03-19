#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JFTOFullCustomWeekStore.h"
#import "JFTOFullCustomWeek.h"
#import "JFTOLift.h"
#import "JFTOLiftStore.h"
#import "JFTOPlan.h"
#import "JFTOWorkoutSetsGenerator.h"
#import "JFTOFullCustomWorkout.h"
#import "JFTOFullCustomWorkoutStore.h"
#import "JSetData.h"
#import "JWorkout.h"
#import "JFTOVariant.h"

@implementation JFTOFullCustomWeekStore

- (Class)modelClass {
    return JFTOFullCustomWeek.class;
}

- (NSArray *)findAll {
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"week" ascending:YES];
    return [self.data sortedArrayUsingDescriptors:@[sd]];
}

- (void)setupDefaults {
    [self createWeeks];
}

- (void)setDefaultsForObject:(id)object {
    JFTOFullCustomWeek *customWeek = object;
    customWeek.workouts = [@[] mutableCopy];
}

- (void)createWeeks {
    NSObject <JFTOPlan> *plan = [[JFTOWorkoutSetsGenerator new] planForVariant:FTO_VARIANT_STANDARD];
    NSDictionary *setsByWeek = [plan generate:nil];
    for (int week = 1; week <= [[setsByWeek allKeys] count]; week++) {
        JFTOFullCustomWeek *customWeek = [self create];
        customWeek.name = [plan weekNames][(NSUInteger) (week - 1)];
        customWeek.week = [NSNumber numberWithInt:week];
        customWeek.incrementAfterWeek = [[plan deloadWeeks] containsObject:[NSNumber numberWithInt:week]];
        [self createWorkoutsForWeek:customWeek];
    }
}

- (void)createWorkoutsForWeek:(JFTOFullCustomWeek *)week {
    for (JFTOLift *ftoLift in [[JFTOLiftStore instance] findAll]) {
        [self createWorkoutsForLift:ftoLift week:week];
    }
}

- (void)createWorkoutsForLift:(JFTOLift *)ftoLift week:(JFTOFullCustomWeek *)week {
    NSObject <JFTOPlan> *plan = [[JFTOWorkoutSetsGenerator new] planForVariant:FTO_VARIANT_STANDARD];
    NSDictionary *setsByWeek = [plan generate:ftoLift];
    NSArray *sets = setsByWeek[week.week];
    JFTOFullCustomWorkout *customWorkout = [[JFTOFullCustomWorkoutStore instance] create];
    customWorkout.lift = ftoLift;
    customWorkout.order = ftoLift.order;
    for (JSetData *setData in sets) {
        [customWorkout.workout addSet:[setData createSet]];
    }

    [week.workouts addObject:customWorkout];
}

- (void)adjustToMainLifts {
    [self removeUnneededWorkouts];
    [self addMissingWorkouts];
}

- (void)addMissingWorkouts {
    for (JFTOLift *ftoLift in [[JFTOLiftStore instance] findAll]) {
        if (![[JFTOFullCustomWorkoutStore instance] find:@"lift" value:ftoLift]) {
            NSObject <JFTOPlan> *plan = [[JFTOWorkoutSetsGenerator new] planForVariant:FTO_VARIANT_STANDARD];
            NSDictionary *setsByWeek = [plan generate:nil];
            for (int week = 1; week <= [[setsByWeek allKeys] count]; week++) {
                JFTOFullCustomWeek *customWeek = [self find:@"week" value:[NSNumber numberWithInt:week]];
                [self createWorkoutsForLift:ftoLift week:customWeek];
            }
        }
    }
}

- (void)removeUnneededWorkouts {
    NSMutableArray *deadWorkouts = [@[] mutableCopy];
    NSArray *lifts = [[JFTOLiftStore instance] findAll];
    for (JFTOFullCustomWorkout *customWorkout in [[JFTOFullCustomWorkoutStore instance] findAll]) {
        if (![lifts containsObject:customWorkout.lift]) {
            [deadWorkouts addObject:customWorkout];
        }
    }

    for (JFTOFullCustomWorkout *customWorkout in deadWorkouts) {
        [[JFTOFullCustomWorkoutStore instance] remove:customWorkout];
        for (JFTOFullCustomWeek *customWeek in [[JFTOFullCustomWeekStore instance] findAll]) {
            if ([customWeek.workouts containsObject:customWorkout]) {
                [customWeek.workouts removeObject:customWorkout];
            }
        }
    }
}


- (JFTOFullCustomWeek *)weekContaining:(JFTOFullCustomWorkout *)workout {
    return [[self findAll] detect:^BOOL(JFTOFullCustomWeek *week) {
        return [week.workouts containsObject:workout];
    }];
}

@end