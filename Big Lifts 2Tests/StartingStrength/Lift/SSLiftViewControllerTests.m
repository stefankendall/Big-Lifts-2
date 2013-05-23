#import "SSLiftViewControllerTests.h"
#import "SSLiftViewController.h"
#import "SSLiftSummaryDataSource.h"
#import "SSWorkoutStore.h"

@implementation SSLiftViewControllerTests

- (void)testSelectingANewWorkoutChangesDataSourceWorkout {
    SSLiftViewController *controller = [SSLiftViewController new];
    [controller viewDidLoad];

    [controller switchWorkoutToIndex:1];
    STAssertEquals([[SSWorkoutStore instance] atIndex:1], [controller.ssLiftSummaryDataSource ssWorkout], @"");
}

@end