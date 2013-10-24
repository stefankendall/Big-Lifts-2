#import "FTOTriumvirateAssistanceTests.h"
#import "FTOTriumvirateAssistance.h"
#import "FTOWorkout.h"
#import "FTOWorkoutStore.h"
#import "Workout.h"
#import "FTOLiftStore.h"
#import "FTOLift.h"
#import "NSArray+Enumerable.h"
#import "Set.h"

@implementation FTOTriumvirateAssistanceTests

- (void)testAddsTriumvirateSets {
    [[FTOTriumvirateAssistance new] setup];
    FTOWorkout *workout = [[FTOWorkoutStore instance] first];
    STAssertEquals([workout.workout.orderedSets count], 16U, @"");
}

- (void) testDoesNothingForUnknownLifts {
    FTOLift *newLift = [[FTOLiftStore instance] create];
    newLift.name = @"Clean";
    [[FTOWorkoutStore instance] switchTemplate];
    [[FTOTriumvirateAssistance new] setup];

    FTOWorkout *cleanWorkout = [[[FTOWorkoutStore instance] findAll] select:^BOOL(FTOWorkout *ftoWorkout) {
        Lift *lift = [ftoWorkout.workout.orderedSets[0] lift];
        return [lift.name isEqualToString:@"Clean"];
    }][0];

    STAssertEquals([cleanWorkout.workout.orderedSets count], 6U, @"");
}

@end