#import <SenTestingKit/SenTestingKit.h>
#import "SSLiftStoreTests.h"
#import "SSLiftStore.h"

@implementation SSLiftStoreTests

- (void)setUp {
    [super setUp];
    [[SSLiftStore instance] empty];
}

- (void)testSetsUpDefaultLifts {
    STAssertEquals([[SSLiftStore instance] count], 5, @"");
}

@end