#import "JFTOFullBoringButBigAssistanceCopyTests.h"
#import "JFTOFullBoringButBigAssistanceCopy.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"
#import "JFTOFullCustomAssistanceWorkout.h"
#import "JWorkout.h"

@implementation JFTOFullBoringButBigAssistanceCopyTests

- (void)testCopiesBoringButBigIntoCustom {
    [[JFTOFullBoringButBigAssistanceCopy new] copyTemplate];

    JFTOFullCustomAssistanceWorkout *workout1 = [[JFTOFullCustomAssistanceWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    JFTOFullCustomAssistanceWorkout *deloadWorkout = [[JFTOFullCustomAssistanceWorkoutStore instance] findAllWhere:@"week" value:@4][0];
    STAssertEquals((int) [workout1.workout.sets count], 5, @"");
    STAssertEquals((int) [deloadWorkout.workout.sets count], 3, @"");
}

@end