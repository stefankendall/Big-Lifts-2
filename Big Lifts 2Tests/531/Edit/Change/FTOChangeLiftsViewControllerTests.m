#import "FTOChangeLiftsViewControllerTests.h"
#import "FTOChangeLiftsViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOChangeLiftCell.h"
#import "RowTextField.h"
#import "FTOLiftStore.h"
#import "FTOLift.h"
#import "FTOWorkout.h"
#import "FTOWorkoutStore.h"

@implementation FTOChangeLiftsViewControllerTests

- (void)testHasRowsForAllLifts {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 4, @"");
}

- (void)testCanChangeLiftNames {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    FTOChangeLiftCell *cell = (FTOChangeLiftCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textField setText:@"Power Clean"];
    [controller textFieldDidEndEditing:(id) cell.textField];
    STAssertEqualObjects([[[FTOLiftStore instance] first] name], @"Power Clean", @"");
}

- (void)testTappingAddRowCausesSegue {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    UINavigationController *nav = [UINavigationController new];
    [nav pushViewController:controller animated:NO];
    int viewCount = [controller.navigationController.viewControllers count];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    STAssertEquals([controller.navigationController.viewControllers count], (NSUInteger) viewCount + 1, @"");
}

- (void)testArrangeHidesAddButton {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    [controller arrangeButtonTapped:controller.arrangeButton];

    int sections = [controller numberOfSectionsInTableView:controller.tableView];
    STAssertEquals(sections, 1, @"");
}

- (void)testCanArrangeLifts {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    FTOLift *firstLift = [[FTOLiftStore instance] first];
    FTOLift *secondLift = [[FTOLiftStore instance] atIndex:1];
    FTOWorkout *firstWorkout = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    FTOWorkout *secondWorkout = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][1];
    [controller tableView:controller.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    STAssertEquals([[FTOLiftStore instance] first], secondLift, @"");
    STAssertEquals([[FTOLiftStore instance] atIndex:1], firstLift, @"");
    STAssertEqualObjects([[[FTOWorkoutStore instance] first] order], @0, @"");
    STAssertEquals([[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0], secondWorkout, @"");
    STAssertEquals([[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][1], firstWorkout, @"");
}

@end