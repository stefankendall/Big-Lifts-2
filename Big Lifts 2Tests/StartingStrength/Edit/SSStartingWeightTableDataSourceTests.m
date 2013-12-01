#import "SSStartingWeightTableDataSourceTests.h"
#import "SSStartingWeightTableDataSource.h"
#import "TextViewCell.h"
#import "JSSLiftStore.h"
#import "SSLift.h"

@implementation SSStartingWeightTableDataSourceTests
@synthesize source, tableView;

- (void)setUp {
    [super setUp];
    source = [[SSStartingWeightTableDataSource alloc] init];
    tableView = [[UITableView alloc] init];
    [tableView setDataSource:source];
    [source setTableView:tableView];
}

- (void)testDidEndEditingUpdatesLiftRecords {
    TextViewCell *cell = (TextViewCell *) [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell textView] setText:@"400.5"];

    [source textViewDidEndEditing:[cell textView]];

    JSSLift *lift = [[JSSLiftStore instance] findAll][0];
    STAssertEquals(lift.weight.doubleValue, 400.5, @"");
}
@end