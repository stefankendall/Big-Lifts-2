#import "OneRepViewControllerTests.h"
#import "OneRepViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"

@implementation OneRepViewControllerTests

- (void) testEstimatesMax {
    OneRepViewController *controller = [self getControllerByStoryboardIdentifier:@"oneRep"];
    [controller.weightField setText:@"300"];
    [controller.repsField setText:@"5"];
    [controller textFieldDidEndEditing: nil];
    STAssertEqualObjects([controller.maxLabel text], @"350", @"");
}

- (void) testDoesNotEstimateMaxIfOneFieldBlank {
    OneRepViewController *controller = [self getControllerByStoryboardIdentifier:@"oneRep"];
    [controller.weightField setText:@"300"];
    [controller.repsField setText:@""];
    [controller textFieldDidEndEditing: nil];
    STAssertEqualObjects([controller.maxLabel text], @"", @"");
}

@end