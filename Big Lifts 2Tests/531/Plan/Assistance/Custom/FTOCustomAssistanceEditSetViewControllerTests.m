#import "FTOCustomAssistanceEditSetViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomAssistanceEditSetViewController.h"
#import "JFTOCustomAssistanceLift.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JSetStore.h"
#import "JSet.h"
#import "PaddingTextField.h"
#import "JFTOLiftStore.h"

@implementation FTOCustomAssistanceEditSetViewControllerTests

- (void)testShowsHidesAddButton {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];
    STAssertFalse([controller.addLiftButton isHidden], @"");

    [[JFTOCustomAssistanceLiftStore instance] create];

    [controller viewWillAppear:NO];
    STAssertTrue([controller.addLiftButton isHidden], @"");
}

- (void)testSetsDataOnAppear {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];
    controller.set = [[JSetStore instance] create];
    controller.set.reps = @5;
    controller.set.percentage = N(75);
    controller.set.lift = [[JFTOCustomAssistanceLiftStore instance] create];
    controller.set.lift.name = @"MyLift";
    [controller viewWillAppear:NO];

    STAssertEqualObjects([controller.liftTextField text], @"MyLift", @"");
    STAssertEquals([controller.liftsPicker selectedRowInComponent:0], 0, @"");
    STAssertEqualObjects([controller.repsTextField text], @"5", @"");
    STAssertEqualObjects([controller.percentageTextField text], @"75", @"");
}

- (void)testUseBigLiftToggleDefaultsOnIfLiftIsFtoLift {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];
    controller.set = [[JSetStore instance] create];
    controller.set.lift = [[JFTOLiftStore instance] create];
    [controller viewWillAppear:NO];
    STAssertTrue(controller.usingBigLift, @"");
    STAssertTrue([controller.useBigLiftSwitch isOn], @"");
}

- (void)testDefaultsToNotBigLifts {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];
    controller.set = [[JSetStore instance] create];
    [controller viewWillAppear:NO];
    STAssertFalse(controller.usingBigLift, @"");
    STAssertFalse([controller.useBigLiftSwitch isOn], @"");
}

@end