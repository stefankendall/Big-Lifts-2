#import "FTOWorkoutCellTests.h"
#import "FTOWorkoutCell.h"
#import "JFTOWorkoutStore.h"
#import "JFTOSet.h"
#import "JFTOWorkout.h"
#import "JLift.h"
#import "JWorkout.h"

@implementation FTOWorkoutCellTests

- (void)testSetSetSetsLabels {
    FTOWorkoutCell *cell = [FTOWorkoutCell create];
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] first];
    JSet *set = ftoWorkout.workout.sets[0];
    set.lift.weight = [NSDecimalNumber decimalNumberWithString:@"200"];
    set.percentage = [NSDecimalNumber decimalNumberWithString:@"60"];
    [cell setSet:set];
    STAssertEqualObjects([[cell.setCell liftLabel] text], set.lift.name, @"");
    STAssertEqualObjects([[cell.setCell weightLabel] text], @"110 lbs", @"");
    STAssertTrue([[[cell.setCell repsLabel] text] rangeOfString:[set.reps stringValue]].location != NSNotFound, @"");
}

- (void)testAdjustForAmrap {
    FTOWorkoutCell *cell = [FTOWorkoutCell create];
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] first];
    JFTOSet *set = ftoWorkout.workout.sets[0];
    set.amrap = YES;
    [cell setSet:set];
    STAssertEqualObjects([[cell.setCell repsLabel] text], @"5+", @"");
}

@end