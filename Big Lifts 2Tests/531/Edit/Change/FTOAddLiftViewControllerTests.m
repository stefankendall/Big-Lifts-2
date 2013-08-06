#import "FTOAddLiftViewControllerTests.h"
#import "FTOAddLiftViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOLiftStore.h"

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
}

@end