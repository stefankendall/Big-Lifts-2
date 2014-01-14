#import "JFTOTriumvirateAssistanceTests.h"
#import "JFTOTriumvirateAssistance.h"
#import "JFTOWorkout.h"
#import "JFTOWorkoutStore.h"
#import "JWorkout.h"

@implementation JFTOTriumvirateAssistanceTests

- (void)testAddsTriumvirateSets {
    [[JFTOTriumvirateAssistance new] setup];
    JFTOWorkout *workout = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEquals([workout.workout.orderedSets count], 16U, @"");
}

@end