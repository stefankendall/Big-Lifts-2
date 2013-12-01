#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOCycleAdjustor.h"
#import "JFTOWorkoutStore.h"
#import "JFTOLiftStore.h"
#import "JFTOAssistanceStore.h"
#import "JFTOPlan.h"
#import "JFTOWorkoutSetsGenerator.h"
#import "JFTOWorkout.h"

@implementation FTOCycleAdjustor

- (void)checkForCycleChange {
    if ([self shouldIncrementLifts]) {
        [[JFTOLiftStore instance] incrementLifts];
    }

    if ([self cycleNeedsToIncrement]) {
        [self nextCycle];
    }
}

- (BOOL)shouldIncrementLifts {
    if ([self cycleNeedsToIncrement]) {
        return YES;
    }

    return [self reachedEndOfIncrementWeek];
}

- (void)nextCycle {
    [[[JFTOWorkoutStore instance] findAll] each:^(JFTOWorkout *ftoWorkout) {
        ftoWorkout.done = NO;
    }];
    [[JFTOAssistanceStore instance] cycleChange];
}

- (BOOL)reachedEndOfIncrementWeek {
    NSObject <JFTOPlan> *ftoPlan = [[JFTOWorkoutSetsGenerator new] planForCurrentVariant];
    for (NSNumber *incrementWeek in [ftoPlan incrementMaxesWeeks]) {
        BOOL upToIncrementDone = YES;
        for (int week = 1; week <= [incrementWeek intValue]; week++) {
            upToIncrementDone &= [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:week]] detect:^BOOL(JFTOWorkout *ftoWorkout) {
                return !ftoWorkout.done;
            }] == nil;
        }

        BOOL anyInNextPartDone = NO;
        int finalWeek = [self finalWeek:ftoPlan];

        for (int week = [incrementWeek intValue] + 1; week <= finalWeek; week++) {
            anyInNextPartDone |= [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:week]] detect:^BOOL(JFTOWorkout *ftoWorkout) {
                return ftoWorkout.done;
            }] != nil;
        }

        return upToIncrementDone && !anyInNextPartDone;
    }

    return NO;
}

- (int)finalWeek:(NSObject <JFTOPlan> *)ftoPlan {
    int finalWeek = 0;
    NSArray *allWeeks = [[ftoPlan generate:nil] allKeys];
    for (NSNumber *week in allWeeks) {
        if ([week intValue] > finalWeek) {
            finalWeek = [week intValue];
        }
    }
    return finalWeek;
}

- (BOOL)cycleNeedsToIncrement {
    JFTOWorkout *incompleteWorkout = [[[JFTOWorkoutStore instance] findAll] detect:^BOOL(JFTOWorkout *ftoWorkout) {
        return !ftoWorkout.done;
    }];
    return incompleteWorkout == nil;
}

@end