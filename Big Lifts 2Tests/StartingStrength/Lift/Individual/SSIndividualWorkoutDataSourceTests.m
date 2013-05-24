#import "SSIndividualWorkoutDataSourceTests.h"
#import "SSIndividualWorkoutDataSource.h"
#import "SSWorkoutStore.h"

@implementation SSIndividualWorkoutDataSourceTests

- (void)setUp {
    [super setUp];
    [[SSWorkoutStore instance] reset];
}

- (void)testReturnsCorrectNumberOfRows {
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    SSIndividualWorkoutDataSource *dataSource = [[SSIndividualWorkoutDataSource alloc] initWithSsWorkout:ssWorkout];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 3, @"");
}

@end