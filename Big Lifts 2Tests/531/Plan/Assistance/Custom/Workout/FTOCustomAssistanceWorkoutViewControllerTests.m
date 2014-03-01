#import "FTOCustomAssistanceWorkoutViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomAssistanceWorkoutViewController.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JWorkout.h"
#import "JSetStore.h"
#import "JSet.h"
#import "JLiftStore.h"
#import "JLift.h"
#import "FTOCustomAssistanceWorkoutSetCell.h"

@implementation FTOCustomAssistanceWorkoutViewControllerTests

- (void)testSetsSetData {
    FTOCustomAssistanceWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAsstWorkout"];

    JSet *set = [[JSetStore instance] create];
    JFTOCustomAssistanceWorkout *customAssistanceWorkout = [[JFTOCustomAssistanceWorkoutStore instance] create];
    controller.workout = customAssistanceWorkout.workout;
    [controller.workout addSet:set];
    set.reps = @5;
    set.percentage = N(100);
    JLift *lift = [[JLiftStore instance] create];
    lift.name = @"LiftName";
    lift.weight = N(200);
    set.lift = lift;

    FTOCustomAssistanceWorkoutSetCell *cell = (FTOCustomAssistanceWorkoutSetCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 0)];
    STAssertEqualObjects([cell.liftName text], @"LiftName", @"");
    STAssertEqualObjects([cell.reps text], @"5x", @"");
    STAssertEqualObjects([cell.weight text], @"200lbs", @"");
}

- (void)testDoesNotCrashWhenArrangingOneItem {
    FTOCustomAssistanceWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAsstWorkout"];

    JSet *set = [[JSetStore instance] create];
    JFTOCustomAssistanceWorkout *customAssistanceWorkout = [[JFTOCustomAssistanceWorkoutStore instance] create];
    controller.workout = customAssistanceWorkout.workout;
    [controller.workout addSet:set];

    [controller tableView:controller.tableView moveRowAtIndexPath:NSIP(0, 0) toIndexPath:NSIP(1, 0)];
}

@end