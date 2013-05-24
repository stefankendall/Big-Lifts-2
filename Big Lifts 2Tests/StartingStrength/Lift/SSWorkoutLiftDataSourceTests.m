#import "SSWorkoutLiftDataSourceTests.h"
#import "SSWorkoutLiftDataSource.h"
#import "SSWorkoutStore.h"

@implementation SSWorkoutLiftDataSourceTests

- (void)setUp {
    [super setUp];
    [[SSWorkoutStore instance] reset];
}

- (void)testReturnsCorrectNumberOfRows {
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    SSWorkoutLiftDataSource *dataSource = [[SSWorkoutLiftDataSource alloc] initWithSsWorkout:ssWorkout];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 3, @"");
}

@end