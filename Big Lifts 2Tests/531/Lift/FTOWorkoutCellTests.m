#import "FTOWorkoutCellTests.h"
#import "FTOWorkoutCell.h"
#import "FTOWorkout.h"
#import "FTOWorkoutStore.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"
#import "FTOSet.h"

@implementation FTOWorkoutCellTests

- (void)testSetSetSetsLabels {
    FTOWorkoutCell *cell = [FTOWorkoutCell create];
    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] first];
    Set *set = ftoWorkout.workout.sets[0];
    set.lift.weight = [NSDecimalNumber decimalNumberWithString:@"200"];
    set.percentage = [NSDecimalNumber decimalNumberWithString:@"60"];
    [cell setSet:set];
    STAssertEqualObjects([[cell.setCell liftLabel] text], set.lift.name, @"");
    STAssertEqualObjects([[cell.setCell weightLabel] text], @"110 lbs", @"");
    STAssertTrue([[[cell.setCell repsLabel] text] rangeOfString:[set.reps stringValue]].location != NSNotFound, @"");
}

- (void)testAdjustForAmrap {
    FTOWorkoutCell *cell = [FTOWorkoutCell create];
    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] first];
    FTOSet *set = ftoWorkout.workout.sets[0];
    set.amrap = YES;
    [cell setSet:set];
    STAssertEqualObjects([[cell.setCell repsLabel] text], @"5+", @"");
}

@end