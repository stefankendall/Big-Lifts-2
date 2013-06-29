#import "SetCellTests.h"
#import "SetCell.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "Set.h"

@implementation SetCellTests

- (void)testSetCellSetsLabels {
    SetCell *cell = [SetCell create];

    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    Workout *workout = [ssWorkout workouts][0];
    Set *set = workout.sets[0];
    [set setWeight:[NSNumber numberWithDouble:300.0]];
    [set setReps:[NSNumber numberWithInt:5]];

    [cell setSet:set];

    STAssertTrue([[[cell repsLabel] text] isEqualToString:@"5x"], @"");
    NSString *weightText = [[cell weightLabel] text];
    STAssertTrue([weightText isEqualToString:@"300.0 lbs"], weightText);
}

@end