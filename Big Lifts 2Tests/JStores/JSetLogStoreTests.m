#import "JSetLogStoreTests.h"
#import "JSetLogStore.h"
#import "JModel.h"

@implementation JSetLogStoreTests

- (void)testDeserializesNullWeight {
    JModel *model = (JModel *) [[JSetLogStore instance] deserializeObject:@"{\"reps\":null,\"weight\":null,\"name\":null,\"warmup\":0,\"assistance\":0,\"amrap\":0,\"uuid\":\"1\"}"];
    STAssertNotNil(model, @"");
}

@end