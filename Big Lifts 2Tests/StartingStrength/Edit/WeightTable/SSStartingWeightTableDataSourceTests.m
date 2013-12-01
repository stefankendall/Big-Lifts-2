#import "SSStartingWeightTableDataSourceTests.h"
#import "TextViewCell.h"
#import "JSSLift.h"
#import "JSSLiftStore.h"
#import "TextViewWithCell.h"

@implementation SSStartingWeightTableDataSourceTests
@synthesize dataSource;

- (void)setUp {
    [super setUp];
    dataSource = [[SSStartingWeightTableDataSource alloc] init];
}

- (void)testDidEndEditingUpdatesLiftRecords {
    TextViewCell *cell = (TextViewCell *) [dataSource tableView:nil cellForRowAtIndexPath:NSIP(0,0)];
    [[cell textView] setText:@"400.5"];
    [dataSource textViewDidEndEditing:[cell textView]];

    JSSLift *lift = [[JSSLiftStore instance] findAll][0];
    STAssertEquals(lift.weight.doubleValue, 400.5, @"");
}

- (void)testLoadsCellsWithExistingLiftData {
    JSSLift *lift = [[JSSLiftStore instance] findAll][2];
    [lift setWeight:[NSNumber numberWithDouble:200]];

    TextViewCell *cell = (TextViewCell *) [dataSource tableView:nil cellForRowAtIndexPath:NSIP(2,0)];
    NSString *weight = [[cell textView] text];
    STAssertEquals(weight.doubleValue, 200.0, @"");
}

- (void)testTextViewsCanGetIndexWithCellReference {
    TextViewCell *cell = (TextViewCell *) [dataSource tableView:nil cellForRowAtIndexPath:NSIP(1,0)];
    STAssertNotNil([[cell textView] cell], @"");
    STAssertEquals([[cell indexPath] row], 1, @"");
    STAssertEquals([[[[cell textView] cell] indexPath] row], 1, @"");
}


@end