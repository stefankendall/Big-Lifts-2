#import "SSWorkoutVariantControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSWorkoutVariantController.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"
#import "SSVariantStore.h"
#import "SSVariant.h"
#import "IAPAdapter.h"
#import "PurchaseOverlay.h"

@implementation SSWorkoutVariantControllerTests

- (void)testSelectNoviceWorkoutChangesWorkout {
    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];
    [controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    SSWorkout *workoutB = [[SSWorkoutStore instance] last];
    Workout *lastWorkout = workoutB.workouts[2];
    Set *firstSet = lastWorkout.sets[0];
    STAssertEqualObjects(firstSet.lift.name, @"Deadlift", @"");
}

- (void)testSelectionChangesVariant {
    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];

    UITableViewCell *standardCell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *noviceCell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    STAssertFalse([[standardCell viewWithTag:1] isHidden], @"");
    STAssertTrue([[noviceCell viewWithTag:1] isHidden], @"");

    [controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    SSVariant *variant = [[SSVariantStore instance] first];
    STAssertEqualObjects(variant.name, @"Novice", @"");

    STAssertTrue([[standardCell viewWithTag:1] isHidden], @"");
    STAssertFalse([[noviceCell viewWithTag:1] isHidden], @"");
}

- (void)testShowsSelectedButtonForCurrentVariant {
    SSVariant *variant = [[SSVariantStore instance] first];
    variant.name = @"Novice";

    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];
    UITableViewCell *cell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UIButton *button = (UIButton *) [cell viewWithTag:1];
    STAssertFalse([button isHidden], @"");
}

- (void)testDoesNotDuplicateOverlayViews {
    [[IAPAdapter instance] addPurchase:@"ssOnusWunsler"];
    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];
    int count = [[[controller.onusWunslerCell subviews][0] subviews] count];
    [controller disableOnusWunsler];
    STAssertEquals([[[controller.onusWunslerCell subviews][0] subviews] count], (NSUInteger) count + 1, @"");
    [controller disableOnusWunsler];
    STAssertEquals([[[controller.onusWunslerCell subviews][0] subviews] count], (NSUInteger) count + 1, @"");
}

- (void)testEnableOnusWunsler {
    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];
    [controller disableOnusWunsler];
    [controller enableOnusWunsler];

    STAssertNil([controller.onusWunslerCell viewWithTag:kPurchaseOverlayTag], @"");
}

@end