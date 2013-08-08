#import "FTOPlanViewControllerTests.h"
#import "FTOPlanViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOVariant.h"
#import "FTOVariantStore.h"
#import "PurchaseOverlay.h"

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
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    FTOVariant *variant = [[FTOVariantStore instance] first];
    STAssertEqualObjects(variant.name, FTO_VARIANT_PYRAMID, @"");
}

- (void)testDisablesAdvancedVariant {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    STAssertNotNil([controller.advancedVariant viewWithTag:kPurchaseOverlayTag], @"");
}

@end