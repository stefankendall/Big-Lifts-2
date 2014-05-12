#import "SJEditViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SJEditViewController.h"
#import "JSJLift.h"
#import "JSJLiftStore.h"

@implementation SJEditViewControllerTests

- (void)testDoesNotSaveNanWeights {
    SJEditViewController *controller = [self getControllerByStoryboardIdentifier:@"sjEditViewController"];
    [controller.liftField setText:@"A"];
    [controller.maxField setText:@""];
    [controller textFieldDidEndEditing:controller.liftField];
    JSJLift *lift = [[JSJLiftStore instance] first];
    STAssertEqualObjects(lift.weight, N(0), @"");
}

@end