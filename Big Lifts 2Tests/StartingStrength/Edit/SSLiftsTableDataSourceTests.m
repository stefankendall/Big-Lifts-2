#import "SSLiftsTableDataSourceTests.h"
#import "SSLiftsTableDataSource.h"

@implementation SSLiftsTableDataSourceTests
- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testHasAllLifts {
    SSLiftsTableDataSource *dataSource = [[SSLiftsTableDataSource alloc] init];
    NSArray *lifts = [self getLiftNamesFromCells:dataSource];
    STAssertTrue([lifts containsObject:@"Squat"], @"");
    STAssertTrue([lifts containsObject:@"Deadlift"], @"");
    STAssertTrue([lifts containsObject:@"Press"], @"");
    STAssertTrue([lifts containsObject:@"Bench"], @"");
    STAssertTrue([lifts containsObject:@"Power Clean"], @"");
}

- (NSArray *) getLiftNamesFromCells:(SSLiftsTableDataSource *)dataSource {
    int liftCount = 5;
    STAssertEquals(liftCount, [dataSource tableView:nil numberOfRowsInSection:@0], @"");
    NSMutableArray *lifts = [@[] mutableCopy];
    for (int i = 0; i < liftCount; i++) {
        UITableViewCell *cell = [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [lifts addObject:cell.textLabel.text];
    }
    return lifts;
}

- (void)testSettingsCanBeUpdated {
}

@end