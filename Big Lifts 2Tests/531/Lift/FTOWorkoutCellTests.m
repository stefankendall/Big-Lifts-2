#import "FTOWorkoutCellTests.h"
#import "FTOWorkoutCell.h"
#import "JFTOWorkoutStore.h"
#import "JFTOSet.h"
#import "FTOLiftWorkoutViewController.h"
#import "JFTOWorkout.h"
#import "JLift.h"
#import "JWorkout.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomAssistanceEditSetViewController.h"

@implementation FTOWorkoutCellTests

- (void)setUp {
    [super setUp];
    JFTOWorkout *jftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    self.controller = [self getControllerByStoryboardIdentifier:@"ftoLiftWorkout"];
    [self.controller setWorkout:jftoWorkout];
}

- (void)testSetSetSetsLabels {
    FTOWorkoutCell *cell = (FTOWorkoutCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:NSIP(0, 1)];
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
    FTOWorkoutCell *cell = (FTOWorkoutCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:NSIP(0, 1)];
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] first];
    JFTOSet *set = ftoWorkout.workout.sets[0];
    set.amrap = YES;
    [cell setSet:set];
    STAssertEqualObjects([[cell.setCell repsLabel] text], @"5+", @"");
}

@end