#import "JFTOTriumvirateAssistanceTests.h"
#import "JFTOTriumvirateAssistance.h"
#import "JFTOWorkout.h"
#import "JFTOWorkoutStore.h"
#import "JWorkout.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"
#import "NSArray+Enumerable.h"
#import "JSet.h"

@implementation JFTOTriumvirateAssistanceTests

- (void)testAddsTriumvirateSets {
    [[JFTOTriumvirateAssistance new] setup];
    JFTOWorkout *workout = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEquals([workout.workout.orderedSets count], 16U, @"");
}

- (void)testDoesNothingForUnknownLifts {
    JFTOLift *newLift = [[JFTOLiftStore instance] create];
    newLift.name = @"Clean";
    [[JFTOWorkoutStore instance] switchTemplate];
    [[JFTOTriumvirateAssistance new] setup];

    JFTOWorkout *cleanWorkout = [[[JFTOWorkoutStore instance] findAll] select:^BOOL(JFTOWorkout *ftoWorkout) {
        JLift *lift = [ftoWorkout.workout.orderedSets[0] lift];
        return [lift.name isEqualToString:@"Clean"];
    }][0];

    STAssertTrue([cleanWorkout.workout.orderedSets count] <= 6, @"");
}

@end