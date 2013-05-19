#import "SSLiftSummaryCellTests.h"
#import "SSLiftSummaryCell.h"
#import "SSLiftStore.h"
#import "SSLift.h"

@implementation SSLiftSummaryCellTests

- (void)testSetLiftSetsLiftLabel {
    SSLiftSummaryCell *cell = [SSLiftSummaryCell createNewTextCellFromNib];
    SSLift *lift = [[SSLiftStore instance] first];
    [cell setLift:lift];

    STAssertTrue([[cell liftLabel].text isEqualToString:lift.name], @"");
}

@end