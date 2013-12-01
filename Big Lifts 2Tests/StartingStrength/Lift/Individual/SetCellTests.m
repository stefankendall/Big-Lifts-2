#import "SetCellTests.h"
#import "SetCell.h"
#import "JSSWorkoutStore.h"
#import "JSSWorkout.h"
#import "JSet.h"
#import "JWorkout.h"
#import "JLift.h"

@implementation SetCellTests

- (void)testSetCellSetsLabels {
    SetCell *cell = [SetCell create];

    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JWorkout *workout = [ssWorkout workouts][0];
    JSet *set = workout.orderedSets[0];
    set.lift.weight = N(300);
    set.percentage = N(100);
    [set setReps:[NSNumber numberWithInt:5]];

    [cell setSet:set];

    STAssertEqualObjects([[cell repsLabel] text], @"5x", @"");
    STAssertEqualObjects([[cell weightLabel] text], @"300 lbs", @"");
    STAssertEqualObjects([[cell percentageLabel] text], @"100%", @"");
}

- (void)testSetCell0Percentage {
    SetCell *cell = [SetCell create];
    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JWorkout *workout = [ssWorkout workouts][0];
    JSet *set = workout.orderedSets[0];
    set.percentage = N(0);
    [cell setSet:set];

    STAssertEqualObjects([[cell percentageLabel] text], @"", @"");
}

- (void)testSetCellHandlesToFailureReps {
    SetCell *cell = [SetCell create];
    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JWorkout *workout = [ssWorkout workouts][0];
    JSet *set = workout.orderedSets[0];
    set.reps = @-1;
    set.amrap = YES;
    [cell setSet:set];

    STAssertEqualObjects([[cell repsLabel] text], @"AMRAP", @"");
}

- (void)testSetCellHandlesRepRanges {
    SetCell *cell = [SetCell create];
    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JWorkout *workout = [ssWorkout workouts][0];
    JSet *set = workout.orderedSets[0];
    set.reps = @5;
    set.maxReps = @8;
    [cell setSet:set];

    STAssertEqualObjects([[cell repsLabel] text], @"5-8x", @"");
}

- (void)testEnteredReps {
    SetCell *cell = [SetCell create];

    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JWorkout *workout = [ssWorkout workouts][0];
    JSet *set = workout.orderedSets[0];
    [set setReps:[NSNumber numberWithInt:5]];
    [cell setSet:set withEnteredReps:@7 withEnteredWeight:nil ];
    STAssertEqualObjects([[cell repsLabel] text], @"7x", @"");
}

- (void)testEnteredWeight {
    SetCell *cell = [SetCell create];
    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JWorkout *workout = [ssWorkout workouts][0];
    JSet *set = workout.orderedSets[0];
    [set setReps:[NSNumber numberWithInt:5]];
    [cell setSet:set withEnteredReps:@1 withEnteredWeight:N(50)];
    STAssertEqualObjects([[cell weightLabel] text], @"50 lbs", @"");
}

- (void)testShowsNoWeightIfWeight0AndNoBar {
    SetCell *cell = [SetCell create];

    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JWorkout *workout = [ssWorkout workouts][0];
    JSet *set = workout.orderedSets[0];
    set.lift.usesBar = NO;
    set.percentage = N(0);
    [cell setSet:set withEnteredReps:@7 withEnteredWeight:N(0) ];
    STAssertEqualObjects([[cell weightLabel] text], @"", @"");
}

@end