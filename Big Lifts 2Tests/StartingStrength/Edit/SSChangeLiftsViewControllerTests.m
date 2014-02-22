#import "SSChangeLiftsViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSChangeLiftsViewController.h"
#import "RowTextField.h"
#import "JSSLift.h"
#import "JSSLiftStore.h"

@implementation SSChangeLiftsViewControllerTests

- (void)testCanChangeCustomName {
    SSChangeLiftsViewController *controller = [self getControllerByStoryboardIdentifier:@"ssChangeLifts"];

    const int ROW = 1;

    JSSLift *secondLift = [[JSSLiftStore instance] atIndex:ROW];
    NSString *oldName = secondLift.name;

    RowTextField *rowTextField = [RowTextField new];
    rowTextField.indexPath = NSIP(ROW, 0);
    [rowTextField setText:@"New name"];

    [controller textFieldDidEndEditing:rowTextField];

    STAssertEqualObjects(secondLift.name, oldName, @"");
    STAssertEqualObjects(secondLift.customName, @"New name", @"");
}

@end