#import "SetCellTests.h"
#import "SetCell.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"

@implementation SetCellTests

- (void)testSetCellSetsLabels {
    SetCell *cell = [SetCell create];

    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    Workout *workout = [ssWorkout workouts][0];
    Set *set = workout.sets[0];
    set.lift.weight = N(300);
    set.percentage = N(100);
    [set setReps:[NSNumber numberWithInt:5]];

    [cell setSet:set];

    STAssertEqualObjects([[cell repsLabel] text], @"5x", @"");
    NSString *weightText = [[cell weightLabel] text];
    STAssertTrue([weightText isEqualToString:@"300 lbs"], weightText);
}

- (void)testSetCellHandlesToFailureReps {
    SetCell *cell = [SetCell create];
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    Workout *workout = [ssWorkout workouts][0];
    Set *set = workout.sets[0];
    set.reps = @-1;
    set.amrap = YES;
    [cell setSet:set];

    STAssertEqualObjects([[cell repsLabel] text], @"AMRAP", @"");
}

- (void)testSetCellHandlesRepRanges {
    SetCell *cell = [SetCell create];
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    Workout *workout = [ssWorkout workouts][0];
    Set *set = workout.sets[0];
    set.reps = @5;
    set.maxReps = @8;
    [cell setSet:set];

    STAssertEqualObjects([[cell repsLabel] text], @"5-8x", @"");
}

- (void)testEnteredReps {
    SetCell *cell = [SetCell create];

    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    Workout *workout = [ssWorkout workouts][0];
    Set *set = workout.sets[0];
    [set setReps:[NSNumber numberWithInt:5]];
    [cell setSet:set withEnteredReps:7];
    STAssertEqualObjects([[cell repsLabel] text], @"7x", @"");
}

@end