#import "JWorkout.h"
#import "JFTOFullTriumvirateAssistanceCopyTests.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOTriumvirateAssistanceCopy.h"
#import "JFTOFullCustomAssistanceWorkout.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"
#import "JFTOFullTriumvirateAssistanceCopy.h"
#import "JFTOCustomAssistanceLiftStore.h"

@implementation JFTOFullTriumvirateAssistanceCopyTests

- (void)testCopiesWorkoutsIntoCustom {
    [[JFTOFullTriumvirateAssistanceCopy new] copyTemplate];
    STAssertEquals([[JFTOCustomAssistanceLiftStore instance] count], 8, @"");

    for (JFTOFullCustomAssistanceWorkout *customAssistanceWorkout in [[JFTOFullCustomAssistanceWorkoutStore instance] findAll]) {
        STAssertEquals((int) [customAssistanceWorkout.workout.sets count], 10, @"");
    }
}

@end