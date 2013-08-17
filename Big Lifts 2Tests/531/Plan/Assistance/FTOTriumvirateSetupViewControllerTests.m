#import "FTOTriumvirateSetupViewControllerTests.h"
#import "FTOTriumvirate.h"
#import "FTOTriumvirateStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOTriumvirateSetupViewController.h"
#import "Workout.h"

@implementation FTOTriumvirateSetupViewControllerTests

- (void) testSetsFieldsFromTriumvirateData {
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] first];
    FTOTriumvirateSetupViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTriumvirateSetup"];

    [controller setupForm:triumvirate forSet:triumvirate.workout.sets[0]];
    STAssertEqualObjects([controller.setsField text], @"5", @"");
    STAssertEqualObjects([controller.repsField text], @"10", @"");
    STAssertEqualObjects([controller.nameField text], @"Leg Press", @"");
}

@end