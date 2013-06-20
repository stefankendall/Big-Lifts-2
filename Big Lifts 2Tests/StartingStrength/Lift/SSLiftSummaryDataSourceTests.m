#import "SSLiftSummaryDataSourceTests.h"
#import "SSWorkoutStore.h"
#import "SSLiftSummaryDataSource.h"
#import "SSLiftSummaryCell.h"

@implementation SSLiftSummaryDataSourceTests
@synthesize dataSource;

- (void)setUp {
    [super setUp];
    dataSource = [[SSLiftSummaryDataSource alloc] initWithSsWorkout:[[SSWorkoutStore instance] first]];
}

- (void)testReturnsCorrectNumberOfRows {
    STAssertEquals(3, [dataSource tableView:nil numberOfRowsInSection:0], @"");
}

- (void)testReturnsLiftSummaryCells {
    UITableViewCell *cell = [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertTrue([cell isKindOfClass:SSLiftSummaryCell.class], @"");
}

@end