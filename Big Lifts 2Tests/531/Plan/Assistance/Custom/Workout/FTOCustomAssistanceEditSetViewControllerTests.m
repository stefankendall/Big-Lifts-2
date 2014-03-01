#import "FTOCustomAssistanceEditSetViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomAssistanceEditSetViewController.h"
#import "JFTOCustomAssistanceLift.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JSetStore.h"
#import "JSet.h"
#import "PaddingTextField.h"
#import "JFTOLiftStore.h"
#import "JFTOSetStore.h"
#import "JFTOSet.h"

@implementation FTOCustomAssistanceEditSetViewControllerTests

- (void)testShowsHidesAddButton {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];
    STAssertFalse([controller.addLiftButton isHidden], @"");

    [[JFTOCustomAssistanceLiftStore instance] create];

    [controller viewWillAppear:NO];
    STAssertTrue([controller.addLiftButton isHidden], @"");
}

- (void)testSetsTrainingMaxToggle {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];
    controller.set = [[JFTOSetStore instance] create];
    [controller viewWillAppear:YES];

    STAssertTrue([controller.useTrainingMaxSwitch isOn], @"");
}

- (void)testTogglingTrainingMaxChangesSetTypes {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];

    controller.set = [[JFTOSetStore instance] create];
    controller.set.lift = [[JFTOLiftStore instance] first];
    controller.set.reps = @5;
    controller.set.percentage = N(50);
    controller.set.amrap = YES;
    int ftoCount = [[JFTOSetStore instance] count];
    [controller.useTrainingMaxSwitch setOn:NO];
    [controller useTrainingMaxChanged:controller.useTrainingMaxSwitch];

    STAssertFalse([controller.set isKindOfClass:JFTOSet.class], @"");
    STAssertEquals(ftoCount - 1, [[JFTOSetStore instance] count], @"");

    STAssertNotNil(controller.set.lift, @"");
    STAssertEqualObjects(controller.set.reps, @5, @"");
    STAssertEqualObjects(controller.set.percentage, N(50), @"");
    STAssertTrue(controller.set.amrap, @"");
}

- (void)testDoesNotCrashWhenUpdatedWithoutLift {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];
    controller.set = [[JSetStore instance] create];
    [controller updateSet];
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
    STAssertEquals((int) [controller.liftsPicker selectedRowInComponent:0], 0, @"");
    STAssertEqualObjects([controller.repsTextField text], @"5", @"");
    STAssertEqualObjects([controller.percentageTextField text], @"75", @"");
}

- (void)testUseBigLiftToggleDefaultsOnIfLiftIsFtoLift {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];
    controller.set = [[JSetStore instance] create];
    controller.set.lift = [[JFTOLiftStore instance] create];
    [controller viewWillAppear:NO];
    STAssertTrue(controller.usingBigLift, @"");
    STAssertNotNil(controller.useBigLiftSwitch, @"");
    STAssertTrue([controller.useBigLiftSwitch isOn], @"");
}

- (void)testDefaultsToNotBigLifts {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];
    controller.set = [[JSetStore instance] create];
    [controller viewWillAppear:NO];
    STAssertFalse(controller.usingBigLift, @"");
    STAssertFalse([controller.useBigLiftSwitch isOn], @"");
}

- (void)testDoesNotCrashWhenAssistanceLiftHasBeenDeleted {
    FTOCustomAssistanceEditSetViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomAssistanceEditSetViewController"];
    controller.set = [[JSetStore instance] create];
    controller.set.lift = [[JFTOCustomAssistanceLiftStore instance] create];
    [[JFTOCustomAssistanceLiftStore instance] remove:controller.set.lift];
    [controller viewWillAppear:NO];
    //pass
}

@end