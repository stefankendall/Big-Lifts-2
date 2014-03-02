#import "JFTOBoringButBigAssistanceCopy.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JWorkout.h"
#import "BoringButBigHelper.h"

@implementation JFTOBoringButBigAssistanceCopy

- (void)copyTemplate {
    for (JFTOCustomAssistanceWorkout *customAssistanceWorkout in [[JFTOCustomAssistanceWorkoutStore instance] findAll]) {
        [BoringButBigHelper addSetsToWorkout:customAssistanceWorkout.workout withLift:(id) customAssistanceWorkout.mainLift deload:NO];
    }
}

@end