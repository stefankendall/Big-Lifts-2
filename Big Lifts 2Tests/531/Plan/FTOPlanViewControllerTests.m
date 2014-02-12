#import "FTOPlanViewControllerTests.h"
#import "FTOPlanViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JFTOVariantStore.h"
#import "PurchaseOverlay.h"
#import "JFTOSettingsStore.h"
#import "JFTOVariant.h"
#import "JFTOSettings.h"
#import "JFTOWorkoutStore.h"

@implementation FTOPlanViewControllerTests

- (void)testSetsUpTrainingMaxFieldOnLoad {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    STAssertFalse([[controller.trainingMaxField text] isEqualToString:@""], @"");
}

- (void)testChecksCurrentFtoVariant {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    STAssertEquals([controller.standardVariant accessoryType], UITableViewCellAccessoryCheckmark, @"");
}

- (void)testChangesVariant {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];

    NSString *oldVariant = [[[JFTOVariantStore instance] first] name];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:1]];
    NSString *newVariant = [[[JFTOVariantStore instance] first] name];

    STAssertFalse([newVariant isEqualToString:oldVariant], @"");
}

- (void)testDisablesAdvancedVariant {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    STAssertNotNil([controller.advancedVariant viewWithTag:kPurchaseOverlayTag], @"");
}

- (void)testSetsWarmupToggleOnLoad {
    [[[JFTOSettingsStore instance] first] setWarmupEnabled:NO];
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    [controller viewWillAppear:YES];
    STAssertFalse([controller.warmupToggle isOn], @"");
}

- (void)testCannotSetTrainingMaxToNil {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    [controller.trainingMaxField setText:@""];
    [controller textFieldDidEndEditing:controller.trainingMaxField];
    STAssertEqualObjects([[[JFTOSettingsStore instance] first] trainingMax], N(100), @"");
}

- (void)testSixWeekToggleOff {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    STAssertFalse([controller.sixWeekToggle isOn], @"");
}

- (void)testSixWeekToggleOn {
    [[[JFTOSettingsStore instance] first] setSixWeekEnabled:YES];
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    STAssertTrue([controller.sixWeekToggle isOn], @"");
}

- (void)testDisablesAndSets6WeekOffForCustom {
    [[[JFTOSettingsStore instance] first] setSixWeekEnabled:YES];
    [[JFTOVariantStore instance] changeTo:FTO_VARIANT_CUSTOM];
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    STAssertFalse([controller.sixWeekToggle isEnabled], @"");
}

- (void)testSelectingAVariantReEnablesSixWeekToggle {
    [[JFTOVariantStore instance] changeTo:FTO_VARIANT_CUSTOM];
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:NSIP(3,1)];
    STAssertTrue([controller.sixWeekToggle isEnabled], @"");
}

- (void)testTogglingSixWeekOnSetsSetting {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    [controller.sixWeekToggle setOn:YES];
    [controller toggleSixWeek:controller.sixWeekToggle];

    STAssertTrue([[[JFTOSettingsStore instance] first] sixWeekEnabled], @"");
}

- (void)testAddsWeeksToWorkouts {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    [controller.sixWeekToggle setOn:YES];
    [controller toggleSixWeek:controller.sixWeekToggle];

    STAssertEquals([[JFTOWorkoutStore instance] count], 28, @"");
}

@end