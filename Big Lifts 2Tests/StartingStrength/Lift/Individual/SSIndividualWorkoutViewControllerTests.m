#import "SSIndividualWorkoutViewControllerTests.h"
#import "SSIndividualWorkoutViewController.h"
#import "SSIndividualWorkoutDataSource.h"
#import "SSWorkoutStore.h"

@implementation SSIndividualWorkoutViewControllerTests

- (void)setUp {
    [super setUp];
    [[SSWorkoutStore instance] reset];
}

- (void)testTappingNextMovesWorkoutForward {
    SSIndividualWorkoutViewController *controller = [SSIndividualWorkoutViewController new];
    [controller viewDidLoad];

    [controller nextButtonTapped:nil];
    STAssertEquals([controller workoutIndex], 1, @"");
    STAssertEquals([[controller individualWorkoutDataSource] workoutIndex], 1, @"");
}

- (void)testLastWorkoutPageHasSaveButton {
    SSIndividualWorkoutViewController *controller = [SSIndividualWorkoutViewController new];
    [controller viewDidLoad];

    [controller nextButtonTapped:nil];
    [controller nextButtonTapped:nil];
    NSString *title = [[[controller navigationItem] rightBarButtonItem] title];
    STAssertTrue([title isEqualToString:@"Done"], title);
}

@end