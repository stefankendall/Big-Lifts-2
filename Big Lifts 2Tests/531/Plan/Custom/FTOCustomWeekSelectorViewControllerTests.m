#import "FTOCustomWeekSelectorViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomWeekSelectorViewController.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWeekEditCell.h"
#import "RowTextField.h"
#import "FTOCustomWorkout.h"

@implementation FTOCustomWeekSelectorViewControllerTests

- (void)testSetsUpRowsForEachWeek {
    FTOCustomWeekSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWeekSelector"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 4, @"");

    UITableViewCell *cell = [controller tableView:controller.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([[cell textLabel] text], @"5/5/5", @"");
}

- (void)testCanDeleteWeeks {
    FTOCustomWeekSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWeekSelector"];
    [controller tableView:controller.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:0]];

    STAssertEquals([[FTOCustomWorkoutStore instance] count], 3, @"");
}

- (void)testCanEditWeekNames {
    FTOCustomWeekSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWeekSelector"];
    [controller editWeekTapped:nil];
    FTOCustomWeekEditCell *cell = (FTOCustomWeekEditCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.nameField setText:@"Starter week"];
    [controller textFieldDidEndEditing:cell.nameField];

    FTOCustomWorkout *firstWorkout = [[FTOCustomWorkoutStore instance] first];
    STAssertEqualObjects(firstWorkout.name, @"Starter week", @"");
}

- (void) testCanAddWeeks {
    FTOCustomWeekSelectorViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomWeekSelector"];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];

    STAssertEquals([[FTOCustomWorkoutStore instance] count], 5, @"");
    STAssertTrue([[[FTOCustomWorkoutStore instance] unique:@"week"] containsObject:@5], @"");
}

@end