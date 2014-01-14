#import "JFTOTriumvirateStoreTests.h"
#import "JFTOLiftStore.h"
#import "JFTOTriumvirateStore.h"

@implementation JFTOTriumvirateStoreTests

- (void)testRemovesTriumvirateWhenLiftsAreAdjusted {
    [[JFTOLiftStore instance] removeAtIndex:0];
    STAssertEquals([[JFTOTriumvirateStore instance] count], 3, @"");
}

- (void)testAddsTriumvirateWhenLiftsAreAdded {
    [[JFTOLiftStore instance] create];
    STAssertEquals([[JFTOTriumvirateStore instance] count], 5, @"");
}

@end