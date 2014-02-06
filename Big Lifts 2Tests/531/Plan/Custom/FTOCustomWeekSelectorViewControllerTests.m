#import "FTOCustomWeekSelectorViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomWeekSelectorViewController.h"
#import "JFTOCustomWorkoutStore.h"
#import "FTOCustomWeekEditCell.h"
#import "RowTextField.h"
#import "JFTOCustomWorkout.h"

@implementation FTOCustomWeekSelectorViewControllerTests

- (void)testSetsUpRowsForEachWeek {
    FTOCustomWeekSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWeekSelector"];
    STAssertEquals((int) [controller tableView:nil numberOfRowsInSection:1], 4, @"");

    UITableViewCell *cell = [controller tableView:controller.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:1]];
    STAssertEqualObjects([[cell textLabel] text], @"5/5/5", @"");
}

- (void)testCanDeleteWeeks {
    FTOCustomWeekSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWeekSelector"];
    [controller tableView:controller.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:0]];

    STAssertEquals([[JFTOCustomWorkoutStore instance] count], 3, @"");
    JFTOCustomWorkout *customWorkout = [[JFTOCustomWorkoutStore instance] first];
    STAssertEquals(customWorkout.week, @1, @"");
}

- (void)testCanEditWeekNames {
    FTOCustomWeekSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWeekSelector"];
    [controller editWeekTapped:nil];
    FTOCustomWeekEditCell *cell = (FTOCustomWeekEditCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.nameField setText:@"Starter week"];
    [controller textFieldDidEndEditing:cell.nameField];

    JFTOCustomWorkout *firstWorkout = [[JFTOCustomWorkoutStore instance] first];
    STAssertEqualObjects(firstWorkout.name, @"Starter week", @"");
}

- (void)testCanAddWeeks {
    FTOCustomWeekSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWeekSelector"];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];

    STAssertEquals([[JFTOCustomWorkoutStore instance] count], 5, @"");
    STAssertTrue([[[JFTOCustomWorkoutStore instance] unique:@"week"] containsObject:@5], @"");
}

@end