#import "JLift.h"
#import "NSArray+Enumerable.h"
#import "JSetData.h"
#import "JFTOCustomPlan.h"
#import "JFTOStandardPlan.h"
#import "JFTOCustomWorkoutStore.h"
#import "JFTOCustomWorkout.h"
#import "JSet.h"
#import "JWorkout.h"

@implementation JFTOCustomPlan

- (NSDictionary *)generate:(JLift *)lift {
    NSArray *customWorkouts = [[JFTOCustomWorkoutStore instance] findAll];

    NSMutableDictionary *template = [@{} mutableCopy];
    for (JFTOCustomWorkout *customWorkout in customWorkouts) {
        NSMutableArray *weekLifts = [@[] mutableCopy];
        [customWorkout.workout.orderedSets each:^(JSet *set) {
            [weekLifts addObject:
                    [JSetData dataWithReps:[set.reps intValue] percentage:set.percentage lift:lift amrap:set.amrap warmup:set.warmup]];
        }];

        template[customWorkout.week] = weekLifts;
    }

    return template;
}

- (NSArray *)deloadWeeks {
    NSMutableArray *weeks = [@[] mutableCopy];
    for (JFTOCustomWorkout *customWorkout in [[JFTOCustomWorkoutStore instance] findAll]) {
        if (![weeks containsObject:customWorkout.week] && customWorkout.deload) {
            [weeks addObject:customWorkout.week];
        }
    }
    return weeks;
}

- (NSArray *)incrementMaxesWeeks {
    NSMutableArray *weeks = [@[] mutableCopy];
    for (JFTOCustomWorkout *customWorkout in [[JFTOCustomWorkoutStore instance] findAll]) {
        if (![weeks containsObject:customWorkout.week] && customWorkout.incrementAfterWeek) {
            [weeks addObject:customWorkout.week];
        }
    }
    return weeks;
}

- (NSArray *)weekNames {
    return [[JFTOStandardPlan new] weekNames];
}

@end