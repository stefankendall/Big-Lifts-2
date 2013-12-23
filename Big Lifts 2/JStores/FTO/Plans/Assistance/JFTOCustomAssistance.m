#import "JFTOCustomAssistance.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JFTOWorkoutStore.h"
#import "JFTOWorkout.h"
#import "JWorkout.h"
#import "FTOCustomAssistanceEditLiftViewController.h"
#import "JSetStore.h"
#import "JSet.h"

@implementation JFTOCustomAssistance

- (void)setup {
    for (JFTOCustomAssistanceWorkout *customAssistanceWorkout in [[JFTOCustomAssistanceWorkoutStore instance] findAll]) {
        for (JFTOWorkout *ftoWorkout in [[JFTOWorkoutStore instance] findAll]) {
            if ([ftoWorkout.workout.sets count] > 0) {
                JFTOLift *lift = [[ftoWorkout.workout.sets firstObject] lift];
                if (customAssistanceWorkout.mainLift == lift) {
                    [self addAssistanceToWorkout:ftoWorkout withAssistance:customAssistanceWorkout];
                }
            }
        }
    }
}

- (void)addAssistanceToWorkout:(JFTOWorkout *)ftoWorkout withAssistance:(JFTOCustomAssistanceWorkout *)assistance {
    for (JSet *set in assistance.workout.sets) {
        JSet *assistanceSet = [[JSetStore instance] createFromSet:set];
        assistanceSet.assistance = YES;
        [ftoWorkout.workout addSet:assistanceSet];
    }
}

- (void)cycleChange {
}

@end