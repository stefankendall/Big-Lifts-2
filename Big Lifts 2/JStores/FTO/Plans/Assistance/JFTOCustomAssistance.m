#import "JFTOCustomAssistance.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JFTOWorkoutStore.h"
#import "JFTOWorkout.h"
#import "JWorkout.h"
#import "FTOCustomAssistanceEditLiftViewController.h"
#import "JSet.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JLift.h"
#import "JFTOCustomAssistanceLift.h"
#import "DecimalNumberHandlers.h"
#import "CustomAssistanceHelper.h"

@implementation JFTOCustomAssistance

- (void)setup {
    for (JFTOCustomAssistanceWorkout *customAssistanceWorkout in [[JFTOCustomAssistanceWorkoutStore instance] findAll]) {
        for (JFTOWorkout *ftoWorkout in [[JFTOWorkoutStore instance] findAll]) {
            if ([ftoWorkout.workout.sets count] > 0) {
                JFTOLift *lift = [[ftoWorkout.workout.sets firstObject] lift];
                if (customAssistanceWorkout.mainLift == lift) {
                    [CustomAssistanceHelper addAssistanceToWorkout:ftoWorkout withAssistance:customAssistanceWorkout.workout];
                }
            }
        }
    }
}

- (void)cycleChange {
    for (JFTOCustomAssistanceLift *lift in [[JFTOCustomAssistanceLiftStore instance] findAll]) {
        lift.weight = [lift.weight decimalNumberByAdding:lift.increment withBehavior:DecimalNumberHandlers.noRaise];
    }
}

@end