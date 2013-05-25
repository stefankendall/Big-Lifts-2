#import "BLStoreTests.h"
#import "BLStore.h"
#import "SetStore.h"

@implementation BLStoreTests

- (void)testCallbacksAreFired {
    SetStore *store = [SetStore instance];

    __block BOOL run = NO;
    [store registerChangeListener:^{
        run = YES;
    }];

    [store fireChanged];
    STAssertTrue(run, @"");
}

- (void)testModelNameDerivedFromStoreName {
    SetStore *store = [SetStore instance];
    STAssertTrue([[store modelName] isEqualToString:@"Set"], @"");
}

@end