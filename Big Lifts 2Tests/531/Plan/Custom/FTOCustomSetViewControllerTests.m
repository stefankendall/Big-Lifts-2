#import "FTOCustomSetViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomSetViewController.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkout.h"
#import "Workout.h"
#import "Set.h"

@implementation FTOCustomSetViewControllerTests

- (void)testSetsLabelsForSet {
    FTOCustomSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomSet"];
    FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] first];
    Set *set = [[customWorkout.workout sets] firstObject];
    set.amrap = YES;
    set.reps = @7;
    set.percentage = N(45);
    set.warmup = YES;
    [controller setSet:set];
    [controller viewWillAppear:YES];

    STAssertEqualObjects(@"7", [controller.repsLabel text], @"");
    STAssertEqualObjects(@"45", [controller.percentageLabel text], @"");
    STAssertTrue([controller.amrapSwitch isOn], @"");
    STAssertTrue([controller.warmupSwitch isOn], @"");
}

- (void)testSetsReps {
    FTOCustomSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomSet"];
    FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] first];
    Set *set = [[customWorkout.workout sets] firstObject];
    set.reps = @7;
    [controller setSet:set];
    [controller viewWillAppear:YES];

    [controller.repsLabel setText:@""];
    [controller textFieldDidEndEditing:controller.repsLabel];
    STAssertEqualObjects(set.reps, @0, @"");

    [controller.repsLabel setText:@"8"];
    [controller textFieldDidEndEditing:controller.repsLabel];
    STAssertEqualObjects(set.reps, @8, @"");
}

@end