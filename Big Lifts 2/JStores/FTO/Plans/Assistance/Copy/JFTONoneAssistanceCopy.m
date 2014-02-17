#import "JFTONoneAssistanceCopy.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JWorkoutStore.h"

@implementation JFTONoneAssistanceCopy

- (void)copyTemplate {
    for (JFTOCustomAssistanceWorkout *customAssistanceWorkout in [[JFTOCustomAssistanceWorkoutStore instance] findAll]) {
        [[JWorkoutStore instance] remove:customAssistanceWorkout.workout];
        customAssistanceWorkout.workout = [[JWorkoutStore instance] create];
    }
}

@end