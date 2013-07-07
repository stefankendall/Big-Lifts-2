#import "SKProductStoreTests.h"
#import "SKProductStore.h"

@implementation SKProductStoreTests

- (void)testLoadGetsIAPInfo {
    [[SKProductStore instance] loadProducts: ^{
        self.done = YES;
    }];
    [self waitForCompletion:5];
    STAssertNotNil([[SKProductStore instance] productById:@"barLoading"], @"");
    STAssertNotNil([[SKProductStore instance] productById:@"ssOnusWunsler"], @"");
}

@end