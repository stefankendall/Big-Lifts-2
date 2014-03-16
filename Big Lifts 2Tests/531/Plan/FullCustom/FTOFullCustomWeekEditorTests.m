#import "FTOFullCustomWeekEditorTests.h"
#import "FTOFullCustomWeekEditor.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOFullCustomWeekCell.h"
#import "PaddingRowTextField.h"
#import "JFTOFullCustomWeekStore.h"
#import "JFTOFullCustomWorkoutStore.h"

@implementation FTOFullCustomWeekEditorTests

- (void)testHasRowForEachWeek {
    FTOFullCustomWeekEditor *editor = [self getControllerByStoryboardIdentifier:@"ftoFullCustomWeekEditor"];
    STAssertEquals((int) [editor tableView:editor.tableView numberOfRowsInSection:0], 4, @"");
}

- (void)testHasWeekNames {
    FTOFullCustomWeekEditor *editor = [self getControllerByStoryboardIdentifier:@"ftoFullCustomWeekEditor"];
    FTOFullCustomWeekCell *cell = (FTOFullCustomWeekCell *) [editor tableView:editor.tableView cellForRowAtIndexPath:NSIP(0, 0)];
    STAssertEqualObjects([cell.nameTextField text], @"5/5/5", @"");
}

- (void)testCanChangeWeekNames {
    FTOFullCustomWeekEditor *editor = [self getControllerByStoryboardIdentifier:@"ftoFullCustomWeekEditor"];
    PaddingRowTextField *textField = [PaddingRowTextField new];
    textField.indexPath = NSIP(0, 0);
    [textField setText:@"new name"];
    [editor textFieldDidEndEditing:textField];

    STAssertEqualObjects([[[JFTOFullCustomWeekStore instance] first] name], @"new name", @"");
}

- (void)testCanDeleteWeeks {
    FTOFullCustomWeekEditor *controller = [self getControllerByStoryboardIdentifier:@"ftoFullCustomWeekEditor"];
    [controller tableView:controller.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:NSIP(0, 0)];

    STAssertEquals([[JFTOFullCustomWeekStore instance] count], 3, @"");
}

- (void)testCanAddWeeks {
    FTOFullCustomWeekEditor *controller = [self getControllerByStoryboardIdentifier:@"ftoFullCustomWeekEditor"];
    [controller tableView:controller.tableView   didSelectRowAtIndexPath:NSIP(0,1)];
    STAssertEquals([[JFTOFullCustomWeekStore instance] count], 5, @"");
    STAssertEquals([[JFTOFullCustomWorkoutStore instance] count], 20, @"");
}

@end