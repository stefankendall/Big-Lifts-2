#import "FTOEditLogViewControllerTests.h"
#import "FTOEditLogViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JWorkoutLog.h"
#import "JWorkoutLogStore.h"

@implementation FTOEditLogViewControllerTests

- (void)testHandlesDatesOfDifferentFormatsAndDoesntCrash {
    FTOEditLogViewController *controller = [[UIStoryboard storyboardWithName:@"FTOEditLogViewController" bundle:nil] instantiateInitialViewController];
    JWorkoutLog *log = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[NSDate new]];
    controller.workoutLog = log;
    [controller viewDidLoad];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    log.date = [dateFormat dateFromString:@"03:03"];
    [controller viewDidLoad];
}

- (void)testSetsDeloadOnAppear {
    FTOEditLogViewController *controller = [[UIStoryboard storyboardWithName:@"FTOEditLogViewController" bundle:nil] instantiateInitialViewController];
    JWorkoutLog *log = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[NSDate new]];
    log.deload = YES;
    controller.workoutLog = log;

    [controller viewWillAppear:NO];
    STAssertTrue(controller.workoutLog.deload, @"");
}

@end