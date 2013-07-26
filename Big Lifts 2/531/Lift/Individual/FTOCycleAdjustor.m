#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOCycleAdjustor.h"
#import "FTOWorkoutStore.h"
#import "FTOWorkout.h"
#import "FTOLiftStore.h"
#import "FTOVariantStore.h"
#import "FTOVariant.h"

@implementation FTOCycleAdjustor

- (void)checkForCycleChange {
    if ([self midPointOfSixWeekCycle]) {
        [[FTOLiftStore instance] incrementLifts];
    }

    if ([self cycleNeedsToIncrement]) {
        [self nextCycle];
    }
}

- (void)nextCycle {
    [[FTOLiftStore instance] incrementLifts];
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *ftoWorkout) {
            ftoWorkout.done = NO;
        }];
}

- (BOOL)midPointOfSixWeekCycle {
    if ([[[[FTOVariantStore instance] first] name] isEqualToString:FTO_VARIANT_SIX_WEEK]) {
        BOOL firstHalfDone = YES;
        for (int week = 1; week <= 3; week++) {
            firstHalfDone &= [[[FTOWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:week]] detect:^BOOL(FTOWorkout *ftoWorkout) {
                return !ftoWorkout.done;
            }] == nil;
        }

        BOOL anyInSecondHalfDone = NO;
        for(int week = 4; week <= 7; week++ ){
            anyInSecondHalfDone |= [[[FTOWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:week]] detect:^BOOL(FTOWorkout *ftoWorkout) {
                return ftoWorkout.done;
            }] != nil;
        }

        return firstHalfDone && !anyInSecondHalfDone;
    }
    return NO;
}

- (BOOL)cycleNeedsToIncrement {
    FTOWorkout *incompleteWorkout = [[[FTOWorkoutStore instance] findAll] detect:^BOOL(FTOWorkout *ftoWorkout) {
        return !ftoWorkout.done;
    }];
    return incompleteWorkout == nil;
}

@end