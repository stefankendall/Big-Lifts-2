#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOCycleAdjustor.h"
#import "FTOWorkoutStore.h"
#import "FTOWorkout.h"
#import "FTOLiftStore.h"
#import "Workout.h"

@implementation FTOCycleAdjustor

- (void)checkForCycleChange {
    if([self cycleNeedsToIncrement]){
        [[FTOLiftStore instance] incrementLifts];
        [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *ftoWorkout) {
            ftoWorkout.done = NO;
        }];
    }
}

- (BOOL)cycleNeedsToIncrement {
    FTOWorkout *incompleteWorkout = [[[FTOWorkoutStore instance] findAll] detect:^BOOL(FTOWorkout *ftoWorkout) {
        return !ftoWorkout.done;
    }];
    return incompleteWorkout == nil;
}

@end