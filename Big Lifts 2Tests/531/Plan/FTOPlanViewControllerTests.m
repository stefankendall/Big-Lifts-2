#import "FTOPlanViewControllerTests.h"
#import "FTOPlanViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOVariant.h"
#import "FTOVariantStore.h"
#import "PurchaseOverlay.h"
#import "FTOWorkout.h"
#import "FTOWorkoutStore.h"
#import "Workout.h"
#import "NSArray+Enumerable.h"
#import "Set.h"
#import "FTOSettingsStore.h"
#import "FTOSettings.h"

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

- (void)testTogglesWarmup {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    UISwitch *toggle = [UISwitch new];
    [toggle setOn:NO];
    [controller toggleWarmup:toggle];
    STAssertFalse([self hasWarmup], @"");

    [toggle setOn:YES];
    [controller toggleWarmup:toggle];
    STAssertTrue([self hasWarmup], @"");
}

- (void)testSetsWarmupToggleOnLoad {
    [[[FTOSettingsStore instance] first] setWarmupEnabled:NO];
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    [controller viewWillAppear:YES];
    STAssertFalse([controller.warmupToggle isOn], @"");
}

- (BOOL)hasWarmup {
    FTOWorkout *workout = [[FTOWorkoutStore instance] first];
    return [workout.workout.orderedSets detect:^BOOL(Set *set) {
        return set.warmup;
    }] != nil;
}

@end