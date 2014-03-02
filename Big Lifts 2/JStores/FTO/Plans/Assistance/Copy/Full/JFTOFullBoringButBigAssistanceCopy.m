#import "JFTOFullBoringButBigAssistanceCopy.h"
#import "BoringButBigHelper.h"
#import "JFTOFullCustomAssistanceWorkout.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"
#import "JFTOWorkoutStore.h"
#import "JFTOWorkout.h"

@implementation JFTOFullBoringButBigAssistanceCopy

- (void)copyTemplate {
    [self addBoringSets];
}

- (void)addBoringSets {
    for (JFTOFullCustomAssistanceWorkout *custom in [[JFTOFullCustomAssistanceWorkoutStore instance] findAll]) {
        JFTOWorkout *testWorkout = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:custom.week][0];
        [BoringButBigHelper addSetsToWorkout:custom.workout withLift:(id) custom.mainLift deload:testWorkout.deload];
    }
}

@end