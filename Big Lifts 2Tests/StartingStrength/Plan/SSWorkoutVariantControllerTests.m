#import "JLift.h"
#import "JSet.h"
#import "SSWorkoutVariantControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSWorkoutVariantController.h"
#import "JSSWorkoutStore.h"
#import "JWorkout.h"
#import "JSSVariantStore.h"
#import "PurchaseOverlay.h"
#import "JSSWorkout.h"
#import "JSSVariant.h"

const int SS_WORKOUT_VARIANT_SECTION = 1;

@implementation SSWorkoutVariantControllerTests

- (void)testSelectNoviceWorkoutChangesWorkout {
    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];
    [controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];

    JSSWorkout *workoutB = [[JSSWorkoutStore instance] last];
    JWorkout *lastWorkout = workoutB.workouts[2];
    JSet *firstSet = lastWorkout.sets[0];
    STAssertEqualObjects(firstSet.lift.name, @"Deadlift", @"");
}

- (void)testSelectionChangesVariant {
    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];

    UITableViewCell *standardCell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:SS_WORKOUT_VARIANT_SECTION]];
    UITableViewCell *noviceCell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:SS_WORKOUT_VARIANT_SECTION]];
    STAssertEquals([standardCell accessoryType], UITableViewCellAccessoryCheckmark, @"");
    STAssertEquals([noviceCell accessoryType], UITableViewCellAccessoryNone, @"");

    [controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    JSSVariant *variant = [[JSSVariantStore instance] first];
    STAssertEqualObjects(variant.name, @"Novice", @"");

    STAssertEquals([standardCell accessoryType], UITableViewCellAccessoryNone, @"");
    STAssertEquals([noviceCell accessoryType], UITableViewCellAccessoryCheckmark, @"");
}

- (void)testShowsSelectedButtonForCurrentVariant {
    JSSVariant *variant = [[JSSVariantStore instance] first];
    variant.name = @"Novice";

    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];
    UITableViewCell *cell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:SS_WORKOUT_VARIANT_SECTION]];
    STAssertEquals([cell accessoryType], UITableViewCellAccessoryCheckmark, @"");
}

- (void)testEnableOnusWunsler {
    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];
    [controller disableView:controller.onusWunslerCell];
    [controller enable:controller.onusWunslerCell];

    STAssertNil([controller.onusWunslerCell viewWithTag:kPurchaseOverlayTag], @"");
}

- (void)testWarmupEnabledSetsToggle {
    [[[JSSVariantStore instance] first] setWarmupEnabled:YES];
    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];
    [controller viewWillAppear:YES];
    STAssertTrue([controller.warmupToggle isOn], @"");
}

- (void)testToggleChangesWarmupEnabled {
    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];
    [controller.warmupToggle setOn:YES];
    [controller toggleWarmup:controller.warmupToggle];
    STAssertTrue([[[JSSVariantStore instance] first] warmupEnabled], @"");
}

@end