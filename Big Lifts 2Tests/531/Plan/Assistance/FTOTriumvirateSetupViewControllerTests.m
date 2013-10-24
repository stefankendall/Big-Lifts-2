#import "Lift.h"
#import "FTOTriumvirateSetupViewControllerTests.h"
#import "FTOTriumvirate.h"
#import "FTOTriumvirateStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOTriumvirateSetupViewController.h"
#import "Workout.h"
#import "Set.h"

@implementation FTOTriumvirateSetupViewControllerTests

- (void)testSetsFieldsFromTriumvirateData {
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] first];
    FTOTriumvirateSetupViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirateSetup"];

    [controller setupForm:triumvirate forSet:triumvirate.workout.orderedSets[0]];
    [controller viewWillAppear:YES];
    STAssertEqualObjects([controller.setsField text], @"5", @"");
    STAssertEqualObjects([controller.repsField text], @"15", @"");
    STAssertEqualObjects([controller.nameField text], @"Dumbbell Bench", @"");
}

- (void)testCanChangeTriumvirateData {
    FTOTriumvirateSetupViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirateSetup"];
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] first];
    [controller setupForm:triumvirate forSet:triumvirate.workout.orderedSets[0]];
    [controller viewWillAppear:YES];
    [controller.setsField setText:@"4"];
    [controller.repsField setText:@"6"];
    [controller.nameField setText:@"Incline Press"];

    [controller textFieldDidEndEditing:nil];

    Set *set = triumvirate.workout.orderedSets[0];
    STAssertEqualObjects(set.lift.name, @"Incline Press", @"");
    STAssertEqualObjects(set.reps, @6, @"");
    STAssertEquals([triumvirate countMatchingSets:set], 4, @"");
}

- (void)testCanRemoveSets {
    FTOTriumvirateSetupViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirateSetup"];
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] first];
    [controller setupForm:triumvirate forSet:triumvirate.workout.orderedSets[0]];
    [controller viewWillAppear:YES];
    [controller removeSets:1];
    STAssertEquals([triumvirate countMatchingSets:triumvirate.workout.orderedSets[0]], 4, @"");
}

- (void)testCanAddSets {
    FTOTriumvirateSetupViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirateSetup"];
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] first];
    [controller setupForm:triumvirate forSet:triumvirate.workout.orderedSets[0]];
    [controller viewWillAppear:YES];
    [controller addSets:1];
    STAssertEquals([triumvirate countMatchingSets:triumvirate.workout.orderedSets[0]], 6, @"");
}

- (void) testDoesNotRemoveAllSets {
    FTOTriumvirateSetupViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirateSetup"];
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] first];
    [controller setupForm:triumvirate forSet:triumvirate.workout.orderedSets[0]];
    [controller viewWillAppear:YES];
    [controller.setsField setText:@"0"];
    [controller textFieldDidEndEditing:nil];
    STAssertEquals([triumvirate countMatchingSets:triumvirate.workout.orderedSets[0]], 5, @"");
}

@end