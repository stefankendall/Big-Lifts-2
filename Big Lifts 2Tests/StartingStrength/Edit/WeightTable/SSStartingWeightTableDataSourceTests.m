#import "SSStartingWeightTableDataSourceTests.h"
#import "SSStartingWeightTableDataSource.h"
#import "TextViewCell.h"
#import "SSLift.h"
#import "BLStore.h"
#import "SSLiftStore.h"

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


@end