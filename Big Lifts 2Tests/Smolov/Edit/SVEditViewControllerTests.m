#import "SVEditViewControllerTests.h"
#import "JSVLift.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SVEditViewController.h"
#import "PaddingRowTextField.h"
#import "JSVLiftStore.h"

@implementation SVEditViewControllerTests

- (void)testCanEditSvLifts {
    SVEditViewController *controller = [self getControllerByStoryboardIdentifier:@"svEdit"];
    PaddingRowTextField *squatTextField = [PaddingRowTextField new];
    [squatTextField setText:@"200.5"];
    squatTextField.indexPath = NSIP(0,0);
    [controller textFieldDidEndEditing:squatTextField];

    PaddingRowTextField *otherTextField = [PaddingRowTextField new];
    [otherTextField setText:@"10.5"];
    otherTextField .indexPath = NSIP(0,1);
    [controller textFieldDidEndEditing:otherTextField];

    STAssertEqualObjects([[[JSVLiftStore instance] atIndex:1] weight], N(10.5), @"");
}

@end