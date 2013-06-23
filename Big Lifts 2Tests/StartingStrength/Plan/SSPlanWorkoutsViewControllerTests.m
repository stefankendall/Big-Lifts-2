#import "SSPlanWorkoutsViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSPlanWorkoutsViewController.h"
#import "SSVariantStore.h"
#import "SSVariant.h"
#import "Workout.h"
#import "SSWorkout.h"
#import "Set.h"
#import "Lift.h"
#import "SSWorkoutStore.h"

@interface SSPlanWorkoutsViewControllerTests ()

@property(nonatomic) SSPlanWorkoutsViewController *controller;
@end

@implementation SSPlanWorkoutsViewControllerTests

- (void)setUp {
    [super setUp];
    self.controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkouts"];
}

- (void)testSetsVariantNameInButtonOnAppear {
    SSVariant *variant = [[SSVariantStore instance] first];
    variant.name = @"Novice";
    [self.controller viewWillAppear:YES];
    STAssertEqualObjects([self.controller.variantButton title], @"Novice", @"");
}

- (void)testNumberOfRowsInSection {
    STAssertEquals(3, [self.controller tableView:nil numberOfRowsInSection:0], @"");
}

- (void)testMoveRowAtIndexPathSwapsLiftOrder {
    [self.controller tableView:nil moveRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    Workout *workout1 = [[[SSWorkoutStore instance] atIndex:0] workouts][0];
    Workout *workout2 = [[[SSWorkoutStore instance] atIndex:0] workouts][1];

    NSString *firstSetLiftName1 = ((Set *) workout1.sets[0]).lift.name;
    STAssertTrue([firstSetLiftName1 isEqualToString:@"Bench"], @"");

    NSString *firstSetLiftName2 = ((Set *) workout2.sets[1]).lift.name;
    STAssertTrue([firstSetLiftName2 isEqualToString:@"Squat"], firstSetLiftName2);
}

- (void)testReturnsIndividualWorkoutNames {
    UITableViewCell *cell1 = [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *cell2 = [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    NSString *cell1Text = [[cell1 textLabel] text];
    NSString *cell2Text = [[cell2 textLabel] text];
    STAssertFalse( [cell1Text isEqualToString:cell2Text], @"");
}

- (void)testReturnsDifferentLiftsForDifferentSections {
    UITableViewCell *section1LastCell = [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITableViewCell *section2LastCell = [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];

    NSString *cell1Text = [[section1LastCell textLabel] text];
    NSString *cell2Text = [[section2LastCell textLabel] text];

    STAssertTrue( [cell1Text isEqualToString:@"Deadlift"], @"");
    STAssertTrue( [cell2Text isEqualToString:@"Power Clean"], @"");
}

- (void)testTargetIndexPathRejectsDifferentSection {
    NSIndexPath *dest = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *source = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *result = [self.controller tableView:nil targetIndexPathForMoveFromRowAtIndexPath:source toProposedIndexPath:dest];
    STAssertEquals(result, source, @"");
}

- (void)testTargetIndexPathAllowsSameSection {
    NSIndexPath *dest = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *source = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *result = [self.controller tableView:nil targetIndexPathForMoveFromRowAtIndexPath:source toProposedIndexPath:dest];
    STAssertEquals(result, dest, @"");
}

@end