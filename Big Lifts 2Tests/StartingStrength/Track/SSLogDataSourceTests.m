#import "SSLogDataSourceTests.h"
#import "SSLogDataSource.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"

@implementation SSLogDataSourceTests

- (void)setUp {
    [super setUp];
    dataSource = [SSLogDataSource new];
}

- (void)createSsLog {
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"Starting Strength";
}

- (void)testReturnsWorkoutLogCell {
    [self createSsLog];
    WorkoutLogCell *cell = (WorkoutLogCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertNotNil([cell setTable], @"");
}

- (void)testReturnsCorrectNumberOfRows {
    [self createSsLog];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 1, @"");
}

- (void)testFiltersByLogName {
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 0, @"");
}

- (void)testDeletesWorkoutLogs {
    [self createSsLog];
    [self createSsLog];
    [dataSource tableView:nil commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEquals([[WorkoutLogStore instance] count], 1, @"");
}

@end