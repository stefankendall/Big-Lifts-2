#import "JFTOBoringButBigLiftStoreTests.h"
#import "JFTOBoringButBigLiftStore.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"
#import "JFTOBoringButBigLift.h"

@implementation JFTOBoringButBigLiftStoreTests

- (void)testSetsUpDefaultLifts {
    STAssertEquals([[JFTOBoringButBigLiftStore instance] count], 4, @"");
}

- (void)testAddsLiftsWhenFtoLiftsAreAdded {
    JFTOLift *newLift = [[JFTOLiftStore instance] create];
    JFTOBoringButBigLift *bbbLift = [[[JFTOBoringButBigLiftStore instance] findAll] lastObject];
    STAssertEquals(bbbLift.mainLift, newLift, @"");
    STAssertEquals(bbbLift.boringLift, newLift, @"");
}

- (void)testRemovesLiftsWhenFtoLiftsAreRemoved {
    [[JFTOLiftStore instance] removeAtIndex:0];
    STAssertEquals([[JFTOBoringButBigLiftStore instance] count], 3, @"");
}

@end