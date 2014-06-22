#import "JFTOSSTLiftStoreTests.h"
#import "JFTOSSTLiftStore.h"
#import "JFTOLiftStore.h"

@implementation JFTOSSTLiftStoreTests

- (void)testSetsUpDefaultLifts {
    STAssertEquals([[JFTOSSTLiftStore instance] count], 4, @"");
}

- (void)testAdjustsToMainLiftsAfterLoad {
    [[JFTOLiftStore instance] removeAtIndex:0];
    [[JFTOSSTLiftStore instance] onLoad];
    STAssertEquals([[JFTOSSTLiftStore instance] count], 3, @"");
}

- (void)testAdjustsSstLiftsWhenLiftsAreModified {
    STAssertEquals([[JFTOSSTLiftStore instance] count], 4, @"");

    [[JFTOLiftStore instance] remove:[[JFTOLiftStore instance] first]];
    STAssertEquals([[JFTOSSTLiftStore instance] count], 3, @"");

    [[JFTOLiftStore instance] create];
    STAssertEquals([[JFTOSSTLiftStore instance] count], 4, @"");
}

@end