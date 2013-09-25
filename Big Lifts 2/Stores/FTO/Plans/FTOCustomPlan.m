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
        [[customWorkout.workout.sets array] each:^(Set *set) {
            [weekLifts addObject:
                    [SetData dataWithReps:[set.reps intValue] percentage:set.percentage lift:lift amrap:set.amrap warmup:NO]];
        }];

        template[customWorkout.week] = weekLifts;
    }

    return template;
}

- (NSArray *)deloadWeeks {
    return @[@4];
}


@end