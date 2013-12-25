#import "JFTOCustomAssistanceWorkoutStoreTests.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOLiftStore.h"
#import "JWorkoutStore.h"

@implementation JFTOCustomAssistanceWorkoutStoreTests

- (void)testSetsUpDefaultPlaceholders {
    STAssertEquals([[JFTOCustomAssistanceWorkoutStore instance] count], 4, @"");
}

- (void)testAdjustsToMainLifts {
    [[JFTOLiftStore instance] removeAtIndex:0];
    STAssertEquals([[JFTOCustomAssistanceWorkoutStore instance] count], 3, @"");
    [[JFTOLiftStore instance] create];
    STAssertEquals([[JFTOCustomAssistanceWorkoutStore instance] count], 4, @"");
}

- (void)testDoesNotLeakWorkouts {
    int workoutCount = [[JWorkoutStore instance] count];
    [[JFTOCustomAssistanceWorkoutStore instance] removeAtIndex:0];
    STAssertEquals(workoutCount - 1, [[JWorkoutStore instance] count], @"");
}

@end