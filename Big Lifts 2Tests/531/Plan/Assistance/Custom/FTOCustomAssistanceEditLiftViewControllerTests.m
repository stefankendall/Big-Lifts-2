#import "FTOCustomAssistanceEditLiftViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomAssistanceEditLiftViewController.h"
#import "JFTOCustomAssistanceLift.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "PaddingTextField.h"

@implementation FTOCustomAssistanceEditLiftViewControllerTests

- (void)testSetsDataOnLoad {
    FTOCustomAssistanceEditLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAsstEditLift"];
    JFTOCustomAssistanceLift *lift = [[JFTOCustomAssistanceLiftStore instance] create];
    lift.name = @"LiftName";
    lift.weight = N(100);
    lift.usesBar = YES;
    lift.increment = N(2);
    controller.lift = lift;
    [controller viewWillAppear:NO];

    STAssertEqualObjects([controller.name text], @"LiftName", @"");
    STAssertEqualObjects([controller.weight text], @"100", @"");
    STAssertEquals([controller.usesBar isOn], YES, @"");
    STAssertEqualObjects([controller.increment text], @"2", @"");
}

- (void) testDoesNotSetIncrementToNan {
    FTOCustomAssistanceEditLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAsstEditLift"];
    JFTOCustomAssistanceLift *lift = [[JFTOCustomAssistanceLiftStore instance] create];
    controller.lift = lift;
    [controller.increment setText:@""];
    [controller updateLift];
    STAssertEqualObjects(lift.increment, N(0), @"");
}

@end