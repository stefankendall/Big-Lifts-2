#import "SVEditViewControllerTests.h"
#import "JSVLift.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SVEditViewController.h"
#import "PaddingRowTextField.h"
#import "JSVLiftStore.h"
#import "LiftFormCell.h"

@implementation SVEditViewControllerTests

- (void)testCanEditSvLifts {
    SVEditViewController *controller = [self getControllerByStoryboardIdentifier:@"svEdit"];
    LiftFormCell *squatCell = (LiftFormCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 0)];
    PaddingRowTextField *squatTextField = squatCell.textField;
    [squatTextField setText:@"200.5"];
    [controller textFieldDidEndEditing:squatTextField];
    STAssertEqualObjects([[[JSVLiftStore instance] atIndex:0] weight], N(200.5), @"");

    LiftFormCell *otherCell = (LiftFormCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 1)];
    PaddingRowTextField *otherTextField = otherCell.textField;
    [otherTextField setText:@"10.5"];
    [controller textFieldDidEndEditing:otherTextField];

    STAssertEqualObjects([[[JSVLiftStore instance] atIndex:1] weight], N(10.5), @"");
}

@end