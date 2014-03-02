
#import "JFTOFullNoneAssistanceCopyTests.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"
#import "JFTOFullCustomAssistanceWorkout.h"
#import "JWorkout.h"
#import "JSetStore.h"
#import "JFTOFullNoneAssistanceCopy.h"

@implementation JFTOFullNoneAssistanceCopyTests

- (void)testEmptiesFullCustomWorkouts {
    JFTOFullCustomAssistanceWorkout *custom = [[JFTOFullCustomAssistanceWorkoutStore instance] create];
    [custom.workout addSet:[[JSetStore instance] create]];

    [[JFTOFullNoneAssistanceCopy new] copyTemplate];

    STAssertEquals((int) [custom.workout.sets count], 0, @"");
}

@end