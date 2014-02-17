#import "SetCellWithPlatesTests.h"
#import "SetCellWithPlates.h"
#import "JSSWorkoutStore.h"
#import "JSSWorkout.h"
#import "JSet.h"
#import "JLift.h"
#import "JWorkout.h"

@implementation SetCellWithPlatesTests

- (void)testSetCellSetsPlates {
    SetCellWithPlates *cell = [SetCellWithPlates create];

    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JWorkout *workout = [ssWorkout workouts][0];
    JSet *set = workout.sets[0];
    set.percentage = N(100);
    set.lift.weight = N(300);
    [cell setSet:set];

    STAssertEqualObjects([[cell platesLabel] text], @"[45, 45, 35, 2.5]", @"");
}

- (void)testSetCellWithoutPlates {
    SetCellWithPlates *cell = [SetCellWithPlates create];

    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JWorkout *workout = [ssWorkout workouts][0];
    JSet *set = workout.sets[0];
    set.percentage = N(100);
    set.lift.weight = N(45);
    [cell setSet:set];

    STAssertEqualObjects([[cell platesLabel] text], @"", @"");
}

- (void)testDoesNotSetPlatesIfLiftDoesNotUseBar {
    SetCellWithPlates *cell = [SetCellWithPlates create];

    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JWorkout *workout = [ssWorkout workouts][0];
    JSet *set = workout.sets[0];
    set.percentage = N(100);
    set.lift.weight = N(200);
    set.lift.usesBar = NO;
    [cell setSet:set];

    STAssertEqualObjects([[cell platesLabel] text], @"", @"");
}

@end