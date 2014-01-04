#import "SVWorkoutViewControllerTests.h"
#import "JSVWorkoutStore.h"
#import "JSVWorkout.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SVWorkoutViewController.h"

@implementation SVWorkoutViewControllerTests

- (void)testHandles1RmDays {
    JSVWorkout *svWorkout = [[JSVWorkoutStore instance] create];
    svWorkout.testMax = YES;

    SVWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"svWorkout"];
    [controller setSvWorkout:svWorkout];

    STAssertEquals([controller tableView:controller.tableView numberOfRowsInSection:0], 1, @"");
}

@end