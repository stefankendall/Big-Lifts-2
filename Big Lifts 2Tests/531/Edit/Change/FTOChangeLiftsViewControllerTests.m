#import "FTOChangeLiftsViewControllerTests.h"
#import "FTOChangeLiftsViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOChangeLiftCell.h"
#import "RowTextField.h"
#import "JFTOLiftStore.h"
#import "JFTOWorkoutStore.h"
#import "JFTOLift.h"
#import "JFTOWorkout.h"

@implementation FTOChangeLiftsViewControllerTests

- (void)testHasRowsForAllLifts {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    STAssertEquals((int) [controller tableView:nil numberOfRowsInSection:0], 4, @"");
}

- (void)testCanChangeLiftNames {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    FTOChangeLiftCell *cell = (FTOChangeLiftCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textField setText:@"Power Clean"];
    [controller textFieldDidEndEditing:(id) cell.textField];
    STAssertEqualObjects([[[JFTOLiftStore instance] first] name], @"Power Clean", @"");
}

- (void)testArrangeHidesAddButton {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    [controller arrangeButtonTapped:controller.arrangeButton];

    int sections = [controller numberOfSectionsInTableView:controller.tableView];
    STAssertEquals(sections, 1, @"");
}

- (void)testCanArrangeLifts {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    JFTOLift *firstLift = [[JFTOLiftStore instance] first];
    STAssertEqualObjects(firstLift.order, @0, @"");
    JFTOLift *secondLift = [[JFTOLiftStore instance] atIndex:1];
    STAssertEqualObjects(secondLift.order, @1, @"");
    JFTOWorkout *firstWorkout = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    JFTOWorkout *secondWorkout = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][1];
    [controller tableView:controller.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    STAssertEquals([[JFTOLiftStore instance] first], secondLift, @"");
    STAssertEquals([[JFTOLiftStore instance] atIndex:1], firstLift, @"");
    STAssertEqualObjects([[[JFTOWorkoutStore instance] first] order], @0, @"");
    STAssertEquals([[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0], secondWorkout, @"");
    STAssertEquals([[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][1], firstWorkout, @"");
}

- (void)testDeletingARowYouAreEditingDoesNotCrashApp {
    FTOChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoChangeLifts"];
    RowTextField *textField = [RowTextField new];
    textField.indexPath = NSIP(5,0);
    [controller textFieldDidEndEditing:textField];
}

@end