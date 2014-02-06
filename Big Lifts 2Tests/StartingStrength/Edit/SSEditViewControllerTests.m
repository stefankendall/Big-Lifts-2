#import "SSEditViewControllerTests.h"
#import "LiftFormCell.h"
#import "TextFieldWithCell.h"
#import "JSSLiftStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSEditViewController.h"
#import "LiftFormCellHelper.h"
#import "JSSLift.h"
#import "PaddingRowTextField.h"

@interface SSEditViewControllerTests ()

@property(nonatomic) SSEditViewController *controller;
@end

@implementation SSEditViewControllerTests

- (void)setUp {
    [super setUp];
    self.controller = [self getControllerByStoryboardIdentifier:@"ssEdit"];
}

- (void)testHasAllLifts {
    NSArray *lifts = [LiftFormCellHelper getLiftNamesFromCells:self.controller count:[[JSSLiftStore instance] count]];
    STAssertTrue([lifts containsObject:@"Squat"], @"");
    STAssertTrue([lifts containsObject:@"Deadlift"], @"");
    STAssertTrue([lifts containsObject:@"Press"], @"");
    STAssertTrue([lifts containsObject:@"Bench"], @"");
    STAssertTrue([lifts containsObject:@"Power Clean"], @"");
}

- (void)testDidEndEditingUpdatesLiftRecords {
    TextFieldCell *cell = (TextFieldCell *) [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell textField] setText:@"400.5"];
    [self.controller textFieldDidEndEditing:[cell textField]];

    JSSLift *lift = [[JSSLiftStore instance] findAll][0];
    STAssertEqualObjects(lift.weight, N(400.5), @"");
}

- (void)testLoadsCellsWithExistingLiftData {
    JSSLift *lift = [[JSSLiftStore instance] findAll][2];
    [lift setWeight:[NSDecimalNumber decimalNumberWithString:@"200"]];

    TextFieldCell *cell = (TextFieldCell *) [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *weight = [[cell textField] text];
    STAssertEquals(weight.doubleValue, 200.0, @"");
}

- (void)testTextViewsCanGetIndexWithCellReference {
    LiftFormCell *cell = (LiftFormCell *) [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    STAssertEquals((int)[[[cell textField] indexPath] row], 1, @"");
}

- (void)testHasAnIncrementSection {
    STAssertEquals((int)[self.controller numberOfSectionsInTableView:nil], 2, @"");
    STAssertEqualObjects([self.controller tableView:nil titleForHeaderInSection:1], @"Increment", @"");
}

- (void)testCanChangeIncrement {
    TextFieldCell *cell = (TextFieldCell *) [self.controller tableView:nil cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:1]];
    [[cell textField] setText:@"6"];
    [self.controller textFieldDidEndEditing:[cell textField]];

    JSSLift *lift = [[JSSLiftStore instance] first];
    STAssertEqualObjects(lift.increment, [NSDecimalNumber decimalNumberWithString:@"6"], @"");
}

@end