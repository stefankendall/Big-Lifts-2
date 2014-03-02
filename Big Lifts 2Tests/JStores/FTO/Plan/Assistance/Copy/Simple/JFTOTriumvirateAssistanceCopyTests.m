#import "JFTOTriumvirateAssistanceCopyTests.h"
#import "JFTOTriumvirateAssistanceCopy.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JWorkout.h"

@implementation JFTOTriumvirateAssistanceCopyTests

- (void)testCopiesTriumvirateIntoCustom {
    [[JFTOTriumvirateAssistanceCopy new] copyTemplate];
    STAssertEquals([[JFTOCustomAssistanceLiftStore instance] count], 8, @"");
}

- (void)testCopiesWorkoutsIntoCustom {
    [[JFTOTriumvirateAssistanceCopy new] copyTemplate];
    STAssertEquals([[JFTOCustomAssistanceWorkoutStore instance] count], 4, @"");
    JFTOCustomAssistanceWorkout *customAssistanceWorkout = [[JFTOCustomAssistanceWorkoutStore instance] first];
    STAssertEquals((int) [customAssistanceWorkout.workout.sets count], 10, @"");
}

@end