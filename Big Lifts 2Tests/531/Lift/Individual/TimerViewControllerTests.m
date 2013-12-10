#import "TimerViewControllerTests.h"
#import "JTimerStore.h"
#import "JTimer.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "TimerViewController.h"
#import "PaddingTextField.h"

@implementation TimerViewControllerTests

-(void) testUsesPersistedStartTimeOnLoad {
    [[[JTimerStore instance] first] setSeconds: @181];
    TimerViewController *controller = [self getControllerByStoryboardIdentifier:@"timer"];
    STAssertEqualObjects([controller.restMinutes text], @"3", @"");
    STAssertEqualObjects([controller.restSeconds text], @"1", @"");
}

@end