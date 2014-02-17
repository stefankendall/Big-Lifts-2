#import "JLift.h"
#import "FTOTriumvirateSetupViewControllerTests.h"
#import "JFTOTriumvirateStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOTriumvirateSetupViewController.h"
#import "JSet.h"
#import "JFTOTriumvirate.h"
#import "JWorkout.h"

@implementation FTOTriumvirateSetupViewControllerTests

- (void)testSetsFieldsFromTriumvirateData {
    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] first];
    FTOTriumvirateSetupViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirateSetup"];

    [controller setupForm:triumvirate forSet:triumvirate.workout.sets[0]];
    [controller viewWillAppear:YES];
    STAssertEqualObjects([controller.setsField text], @"5", @"");
    STAssertEqualObjects([controller.repsField text], @"15", @"");
    STAssertEqualObjects([controller.nameField text], @"Dumbbell Bench", @"");
}

- (void)testCanChangeTriumvirateData {
    FTOTriumvirateSetupViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirateSetup"];
    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] first];
    [controller setupForm:triumvirate forSet:triumvirate.workout.sets[0]];
    [controller viewWillAppear:YES];
    [controller.setsField setText:@"4"];
    [controller.repsField setText:@"6"];
    [controller.nameField setText:@"Incline Press"];

    [controller textFieldDidEndEditing:nil];

    JSet *set = triumvirate.workout.sets[0];
    STAssertEqualObjects(set.lift.name, @"Incline Press", @"");
    STAssertEqualObjects(set.reps, @6, @"");
    STAssertEquals([triumvirate countMatchingSets:set], 4, @"");
}

- (void)testCanRemoveSets {
    FTOTriumvirateSetupViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirateSetup"];
    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] first];
    [controller setupForm:triumvirate forSet:triumvirate.workout.sets[0]];
    [controller viewWillAppear:YES];
    [controller removeSets:1];
    STAssertEquals([triumvirate countMatchingSets:triumvirate.workout.sets[0]], 4, @"");
}

- (void)testCanAddSets {
    FTOTriumvirateSetupViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirateSetup"];
    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] first];
    [controller setupForm:triumvirate forSet:triumvirate.workout.sets[0]];
    [controller viewWillAppear:YES];
    [controller addSets:1];
    STAssertEquals([triumvirate countMatchingSets:triumvirate.workout.sets[0]], 6, @"");
}

- (void)testDoesNotRemoveAllSets {
    FTOTriumvirateSetupViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirateSetup"];
    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] first];
    [controller setupForm:triumvirate forSet:triumvirate.workout.sets[0]];
    [controller viewWillAppear:YES];
    [controller.setsField setText:@"0"];
    [controller textFieldDidEndEditing:nil];
    STAssertEquals([triumvirate countMatchingSets:triumvirate.workout.sets[0]], 5, @"");
}

@end