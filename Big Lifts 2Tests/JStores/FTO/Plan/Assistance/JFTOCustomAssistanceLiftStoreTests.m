#import "JFTOCustomAssistanceLiftStoreTests.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JFTOCustomAssistanceLift.h"

@implementation JFTOCustomAssistanceLiftStoreTests

- (void)testSetsOrderOnCreate {
    JFTOCustomAssistanceLift *lift1 = [[JFTOCustomAssistanceLiftStore instance] create];
    JFTOCustomAssistanceLift *lift2 = [[JFTOCustomAssistanceLiftStore instance] create];

    STAssertEqualObjects(lift1.order, @0, @"");
    STAssertEqualObjects(lift2.order, @1, @"");
}
@end