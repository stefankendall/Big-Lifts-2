#import "FTOFullCustomWorkoutViewControllerTests.h"
#import "FTOFullCustomWorkoutViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JFTOFullCustomWorkout.h"
#import "JFTOFullCustomWorkoutStore.h"
#import "JWorkout.h"

@implementation FTOFullCustomWorkoutViewControllerTests

- (void)testSetsTitleOnViewAppear {
    FTOFullCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoFullCustomWorkout"];
    controller.customWorkout = [[JFTOFullCustomWorkoutStore instance] first];
    [controller viewWillAppear:NO];
    STAssertEqualObjects([controller title], @"5/5/5, Bench", @"");
}

- (void)testCanAddSets {
    FTOFullCustomWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoFullCustomWorkout"];
    controller.customWorkout = [[JFTOFullCustomWorkoutStore instance] first];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:NSIP(0,1)];

    STAssertEquals((int) [[[controller.customWorkout workout] sets] count], 7, @"");
}

@end