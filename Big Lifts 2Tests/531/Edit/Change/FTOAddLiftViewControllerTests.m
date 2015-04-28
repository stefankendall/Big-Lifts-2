#import "FTOAddLiftViewControllerTests.h"
#import "FTOAddLiftViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JFTOLiftStore.h"
#import "JFTOWorkoutStore.h"
#import "JFTOLift.h"

@implementation FTOAddLiftViewControllerTests

- (void)testAllFieldsAreFilled {
    FTOAddLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAddLift"];
    STAssertFalse([controller allFieldsAreFilled], @"");

    [controller.nameField setText:@"Name"];
    [controller.weightField setText:@"130.5"];
    STAssertTrue([controller allFieldsAreFilled], @"");

    [controller.increaseField setText:@"2"];
    STAssertTrue([controller allFieldsAreFilled], @"");
}

- (void)testAddsLifts {
    FTOAddLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAddLift"];
    [controller.nameField setText:@"Name"];
    [controller.weightField setText:@"130.5"];
    [controller.increaseField setText:@"2"];

    int oldCount = [[JFTOLiftStore instance] count];
    [controller doneButtonTapped:nil];
    STAssertEquals(oldCount + 1, [[JFTOLiftStore instance] count], @"");

    JFTOLift *lift = [[JFTOLiftStore instance] find:@"name" value:@"Name"];
    STAssertTrue(lift.usesBar, @"");
}

- (void)testAddsLiftsToWorkouts {
    FTOAddLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAddLift"];
    int oldCount = [[JFTOWorkoutStore instance] count];
    [controller doneButtonTapped:nil];
    STAssertEquals(oldCount + 4, [[JFTOWorkoutStore instance] count], @"");
}

@end