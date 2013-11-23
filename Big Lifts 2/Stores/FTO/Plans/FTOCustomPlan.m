#import "FTOCustomPlan.h"
#import "Lift.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkout.h"
#import "Workout.h"
#import "NSArray+Enumerable.h"
#import "Set.h"
#import "SetData.h"

@implementation FTOCustomPlan

- (NSDictionary *)generate:(Lift *)lift {
    NSArray *customWorkouts = [[FTOCustomWorkoutStore instance] findAll];

    NSMutableDictionary *template = [@{} mutableCopy];
    for (FTOCustomWorkout *customWorkout in customWorkouts) {
        NSMutableArray *weekLifts = [@[] mutableCopy];
        [customWorkout.workout.orderedSets each:^(Set *set) {
            [weekLifts addObject:
                    [SetData dataWithReps:[set.reps intValue] percentage:set.percentage lift:lift amrap:set.amrap warmup:set.warmup]];
        }];

        template[customWorkout.week] = weekLifts;
    }

    return template;
}

- (NSArray *)deloadWeeks {
    return @[@4];
}

- (NSArray *)incrementMaxesWeeks {
    NSMutableArray *weeks = [@[] mutableCopy];
    for (FTOCustomWorkout *customWorkout in [[FTOCustomWorkoutStore instance] findAll]) {
        if(![weeks containsObject:customWorkout.week] && customWorkout.incrementAfterWeek){
            [weeks addObject:customWorkout.week];
        }
    }
    return weeks;
}

@end