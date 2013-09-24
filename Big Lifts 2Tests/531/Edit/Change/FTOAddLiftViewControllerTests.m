#import "FTOAddLiftViewControllerTests.h"
#import "FTOAddLiftViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOLiftStore.h"
#import "FTOWorkoutStore.h"
#import "FTOLift.h"

@implementation FTOAddLiftViewControllerTests

-(void) testAllFieldsAreFilled {
    FTOAddLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAddLift"];
    STAssertFalse([controller allFieldsAreFilled], @"");

    [controller.nameField setText:@"Name"];
    [controller.weightField setText:@"130.5"];
    STAssertFalse([controller allFieldsAreFilled], @"");

    [controller.increaseField setText:@"2"];
    STAssertTrue([controller allFieldsAreFilled], @"");
}

- (void) testAddsLifts {
    FTOAddLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAddLift"];
    [controller.nameField setText:@"Name"];
    [controller.weightField setText:@"130.5"];
    [controller.increaseField setText:@"2"];

    int oldCount = [[FTOLiftStore instance] count];
    [controller doneButtonTapped:nil];
    STAssertEquals(oldCount + 1, [[FTOLiftStore instance] count], @"");

    FTOLift *lift = [[FTOLiftStore instance] find:@"name" value:@"Name"];
    STAssertTrue(lift.usesBar, @"");
}

- (void) testAddsLiftsToWorkouts {
    FTOAddLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoAddLift"];
    int oldCount = [[FTOWorkoutStore instance] count];
    [controller doneButtonTapped:nil];
    STAssertEquals(oldCount + 4, [[FTOWorkoutStore instance] count], @"");
}

@end