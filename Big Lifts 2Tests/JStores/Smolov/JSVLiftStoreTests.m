#import "JSVLiftStoreTests.h"
#import "JSVLiftStore.h"
#import "JSVLift.h"

@implementation JSVLiftStoreTests

- (void)testHasDataOnLoad {
    STAssertEquals([[JSVLiftStore instance] count], 6, @"");
}

- (void)testSquatIsPrimaryLift {
    JSVLift *squat = [[JSVLiftStore instance] find:@"name" value: @"Squat"];
    STAssertEqualObjects(squat.name, @"Squat", @"");
    JSVLift *primary = [[JSVLiftStore instance] first];
    STAssertEqualObjects(primary.name, @"Squat", @"");
}

@end