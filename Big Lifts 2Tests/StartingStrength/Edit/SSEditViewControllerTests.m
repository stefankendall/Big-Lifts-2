#import "SSEditViewControllerTests.h"
#import "TextFieldCell.h"
#import "TextFieldWithCell.h"
#import "SSLift.h"
#import "BLStore.h"
#import "SSLiftStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSEditViewController.h"
#import "LiftFormCellHelper.h"

@interface SSEditViewControllerTests ()

@property(nonatomic) SSEditViewController *controller;
@end

@implementation SSEditViewControllerTests

- (void)setUp {
    [super setUp];
    self.controller = [self getControllerByStoryboardIdentifier:@"ssEdit"];
}

- (void)testHasAllLifts {
    NSArray *lifts = [LiftFormCellHelper getLiftNamesFromCells:self.controller count:[[SSLiftStore instance] count]];
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

    SSLift *lift = [[SSLiftStore instance] findAll][0];
    STAssertEquals(lift.weight.doubleValue, 400.5, @"");
}

- (void)testLoadsCellsWithExistingLiftData {
    SSLift *lift = [[SSLiftStore instance] findAll][2];
    [lift setWeight:[NSDecimalNumber decimalNumberWithString:@"200"]];

    TextFieldCell *cell = (TextFieldCell *) [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *weight = [[cell textField] text];
    STAssertEquals(weight.doubleValue, 200.0, @"");
}

- (void)testTextViewsCanGetIndexWithCellReference {
    TextFieldCell *cell = (TextFieldCell *) [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    STAssertNotNil([[cell textField] cell], @"");
    STAssertEquals([[cell indexPath] row], 1, @"");
    STAssertEquals([[[[cell textField] cell] indexPath] row], 1, @"");
}

- (void)testHasAnIncrementSection {
    STAssertEquals([self.controller numberOfSectionsInTableView:nil], 2, @"");
    STAssertEqualObjects([self.controller tableView:nil titleForHeaderInSection:1], @"Increment", @"");
}

- (void)testCanChangeIncrement {
    TextFieldCell *cell = (TextFieldCell *) [self.controller tableView:nil cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:1]];
    [[cell textField] setText:@"6"];
    [self.controller textFieldDidEndEditing:[cell textField]];

    SSLift *lift = [[SSLiftStore instance] first];
    STAssertEqualObjects(lift.increment, [NSDecimalNumber decimalNumberWithString:@"6"], @"");
}

@end