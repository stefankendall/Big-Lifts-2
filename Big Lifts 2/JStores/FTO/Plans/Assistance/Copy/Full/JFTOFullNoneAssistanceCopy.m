#import "JFTOFullNoneAssistanceCopy.h"
#import "JFTOFullCustomAssistanceWorkout.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"
#import "JWorkoutStore.h"

@implementation JFTOFullNoneAssistanceCopy

- (void)copyTemplate {
    for (JFTOFullCustomAssistanceWorkout *customAssistanceWorkout in [[JFTOFullCustomAssistanceWorkoutStore instance] findAll]) {
        [[JWorkoutStore instance] remove:customAssistanceWorkout.workout];
        customAssistanceWorkout.workout = [[JWorkoutStore instance] create];
    }
}

@end