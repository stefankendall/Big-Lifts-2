#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JFTOFullCustomPlan.h"
#import "JLift.h"
#import "JFTOFullCustomWeekStore.h"
#import "JFTOFullCustomWorkout.h"
#import "JFTOFullCustomWeek.h"
#import "JSet.h"
#import "JWorkout.h"
#import "JSetData.h"

@implementation JFTOFullCustomPlan

- (NSDictionary *)generate:(JLift *)lift {
    NSMutableDictionary *setsForLift = [@{} mutableCopy];
    for (JFTOFullCustomWeek *customWeek in [[JFTOFullCustomWeekStore instance] findAll]) {
        setsForLift[customWeek.week] = [@[] mutableCopy];
        JFTOFullCustomWorkout *workoutForLift = [self workoutForLift:lift inWeek:customWeek];

        [workoutForLift.workout.sets each:^(JSet *set) {
            [setsForLift[customWeek.week] addObject:
                    [JSetData dataWithReps:[set.reps intValue] percentage:set.percentage lift:set.lift amrap:set.amrap warmup:set.warmup]];
        }];
    }

    return setsForLift;
}

- (JFTOFullCustomWorkout *)workoutForLift:(JLift *)lift inWeek:(JFTOFullCustomWeek *)week {
    return [week.workouts detect:^BOOL(JFTOFullCustomWorkout *customWorkout) {
        return [customWorkout lift] == (id) lift;
    }];
}

- (NSArray *)deloadWeeks {
    return @[];
}

- (NSArray *)incrementMaxesWeeks {
    NSMutableArray *maxesWeeks = [@[] mutableCopy];
    for (JFTOFullCustomWeek *customWeek in [[JFTOFullCustomWeekStore instance] findAll]) {
        if (customWeek.incrementAfterWeek) {
            [maxesWeeks addObject:customWeek.week];
        }
    }
    return maxesWeeks;
}

- (NSArray *)weekNames {
    NSMutableArray *weekNames = [@[] mutableCopy];
    for (JFTOFullCustomWeek *customWeek in [[JFTOFullCustomWeekStore instance] findAll]) {
        [weekNames addObject:customWeek.name];
    }
    return weekNames;
}

@end