#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOCycleAdjustor.h"
#import "FTOWorkoutStore.h"
#import "FTOWorkout.h"
#import "FTOLiftStore.h"
#import "FTOAssistanceStore.h"
#import "FTOPlan.h"
#import "FTOWorkoutSetsGenerator.h"

@implementation FTOCycleAdjustor

- (void)checkForCycleChange {
    if ([self shouldIncrementLifts]) {
        [[FTOLiftStore instance] incrementLifts];
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
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *ftoWorkout) {
        ftoWorkout.done = NO;
    }];
    [[FTOAssistanceStore instance] cycleChange];
}

- (BOOL)reachedEndOfIncrementWeek {
    NSObject <FTOPlan> *ftoPlan = [[FTOWorkoutSetsGenerator new] planForCurrentVariant];
    for (NSNumber *incrementWeek in [ftoPlan incrementMaxesWeeks]) {
        BOOL upToIncrementDone = YES;
        for (int week = 1; week <= [incrementWeek intValue]; week++) {
            upToIncrementDone &= [[[FTOWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:week]] detect:^BOOL(FTOWorkout *ftoWorkout) {
                return !ftoWorkout.done;
            }] == nil;
        }

        BOOL anyInNextPartDone = NO;
        int finalWeek = [self finalWeek:ftoPlan];

        for (int week = [incrementWeek intValue] + 1; week <= finalWeek; week++) {
            anyInNextPartDone |= [[[FTOWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:week]] detect:^BOOL(FTOWorkout *ftoWorkout) {
                return ftoWorkout.done;
            }] != nil;
        }

        return upToIncrementDone && !anyInNextPartDone;
    }

    return NO;
}

- (int)finalWeek:(NSObject <FTOPlan> *)ftoPlan {
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
    FTOWorkout *incompleteWorkout = [[[FTOWorkoutStore instance] findAll] detect:^BOOL(FTOWorkout *ftoWorkout) {
        return !ftoWorkout.done;
    }];
    return incompleteWorkout == nil;
}

@end