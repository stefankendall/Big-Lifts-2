#import "SSStartingWeightTableDataSourceTests.h"
#import "TextViewCell.h"
#import "SSLift.h"
#import "BLStore.h"
#import "SSLiftStore.h"
#import "TextViewWithCell.h"

@implementation SSStartingWeightTableDataSourceTests
@synthesize dataSource;

- (void)setUp {
    [super setUp];
    dataSource = [[SSStartingWeightTableDataSource alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDidEndEditingUpdatesLiftRecords {
    TextViewCell *cell = (TextViewCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell textView] setText:@"400.5"];
    [dataSource textViewDidEndEditing:[cell textView]];

    SSLift *lift = [[SSLiftStore instance] findAll][0];
    STAssertEquals(lift.weight.doubleValue, 400.5, @"");
}

- (void)testLoadsCellsWithExistingLiftData {
    SSLift *lift = [[SSLiftStore instance] findAll][2];
    [lift setWeight:[NSNumber numberWithDouble:200]];

    TextViewCell *cell = (TextViewCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *weight = [[cell textView] text];
    STAssertEquals(weight.doubleValue, 200.0, @"");
}

- (void)testTextViewsCanGetIndexWithCellReference {
    TextViewCell *cell = (TextViewCell *) [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    STAssertNotNil([[cell textView] cell], @"");
    STAssertEquals([[cell indexPath] row], 1, @"");
    STAssertEquals([[[[cell textView] cell] indexPath] row], 1, @"");
}


@end