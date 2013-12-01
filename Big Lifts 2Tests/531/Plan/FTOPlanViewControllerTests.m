#import "FTOPlanViewControllerTests.h"
#import "FTOPlanViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOVariant.h"
#import "JFTOVariantStore.h"
#import "PurchaseOverlay.h"
#import "FTOSettingsStore.h"
#import "FTOSettings.h"
#import "JFTOVariant.h"

@implementation FTOPlanViewControllerTests

- (void)testSetsUpTrainingMaxFieldOnLoad {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    STAssertFalse([[controller.trainingMaxField text] isEqualToString:@""], @"");
}

- (void)testChecksCurrentFtoVariant {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    STAssertEquals([controller.standardVariant accessoryType], UITableViewCellAccessoryCheckmark, @"");
}

- (void)testSelectVariant {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    JFTOVariant *variant = [[JFTOVariantStore instance] first];
    STAssertEqualObjects(variant.name, FTO_VARIANT_PYRAMID, @"");
}

- (void)testDisablesAdvancedVariant {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    STAssertNotNil([controller.advancedVariant viewWithTag:kPurchaseOverlayTag], @"");
}

- (void)testSetsWarmupToggleOnLoad {
    [[[FTOSettingsStore instance] first] setWarmupEnabled:NO];
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    [controller viewWillAppear:YES];
    STAssertFalse([controller.warmupToggle isOn], @"");
}

@end