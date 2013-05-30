#import "SSLiftFormDataSourceTests.h"
#import "SSLiftFormDataSource.h"
#import "TextFieldCell.h"
#import "TextFieldWithCell.h"
#import "SSLift.h"
#import "BLStore.h"
#import "SSLiftStore.h"
#import "SSLiftFormCell.h"

@implementation SSLiftFormDataSourceTests
@synthesize dataSource;

- (void)setUp {
    [super setUp];
    dataSource = [SSLiftFormDataSource new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testHasAllLifts {
    NSArray *lifts = [self getLiftNamesFromCells:dataSource];
    STAssertTrue([lifts containsObject:@"Squat"], @"");
    STAssertTrue([lifts containsObject:@"Deadlift"], @"");
    STAssertTrue([lifts containsObject:@"Press"], @"");
    STAssertTrue([lifts containsObject:@"Bench"], @"");
    STAssertTrue([lifts containsObject:@"Power Clean"], @"");
}

- (NSArray *)getLiftNamesFromCells:(SSLiftFormDataSource *)dataSource1 {
    int liftCount = 5;
    STAssertEquals(liftCount, [dataSource1 tableView:nil numberOfRowsInSection:@0], @"");
    NSMutableArray *lifts = [@[] mutableCopy];
    for (int i = 0; i < liftCount; i++) {
        SSLiftFormCell *cell = (SSLiftFormCell *) [dataSource1 tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [lifts addObject:cell.liftLabel.text];
    }
    return lifts;
}

- (void)testDidEndEditingUpdatesLiftRecords {
    TextFieldCell *cell = (TextFieldCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell textField] setText:@"400.5"];
    [dataSource textFieldDidEndEditing:[cell textField]];

    SSLift *lift = [[SSLiftStore instance] findAll][0];
    STAssertEquals(lift.weight.doubleValue, 400.5, @"");
}

- (void)testLoadsCellsWithExistingLiftData {
    SSLift *lift = [[SSLiftStore instance] findAll][2];
    [lift setWeight:[NSNumber numberWithDouble:200]];

    TextFieldCell *cell = (TextFieldCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *weight = [[cell textField] text];
    STAssertEquals(weight.doubleValue, 200.0, @"");
}

- (void)testTextViewsCanGetIndexWithCellReference {
    TextFieldCell *cell = (TextFieldCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    STAssertNotNil([[cell textField] cell], @"");
    STAssertEquals([[cell indexPath] row], 1, @"");
    STAssertEquals([[[[cell textField] cell] indexPath] row], 1, @"");
}


@end