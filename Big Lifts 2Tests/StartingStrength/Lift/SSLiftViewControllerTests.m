#import "SSLiftViewControllerTests.h"
#import "SSLiftViewController.h"
#import "SSLiftSummaryDataSource.h"
#import "SSWorkoutStore.h"

@implementation SSLiftViewControllerTests

- (void)testSelectingANewWorkoutChangesDataSourceWorkout {
    SSLiftViewController *controller = [SSLiftViewController new];
    [controller viewDidLoad];

    [controller switchWorkoutToIndex:1];
    SSWorkout *workoutB = [[SSWorkoutStore instance] atIndex:1];
    STAssertEquals(workoutB, [controller.ssLiftSummaryDataSource ssWorkout], @"");
    STAssertEquals(workoutB, controller.ssWorkout, @"");

}

@end