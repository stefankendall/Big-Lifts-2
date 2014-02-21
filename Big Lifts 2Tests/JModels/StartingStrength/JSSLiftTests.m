#import "JSSLiftTests.h"
#import "JSSLiftStore.h"
#import "JLift.h"
#import "JSSLift.h"

@implementation JSSLiftTests

- (void)testComputesEffectiveName {
    JSSLift *lift = [[JSSLiftStore instance] create];
    lift.name = @"name";

    lift.customName = nil;
    STAssertEqualObjects(@"name", [lift effectiveName], @"");

    lift.customName = @"";
    STAssertEqualObjects(@"name", [lift effectiveName], @"");

    lift.customName = @"new name";
    STAssertEqualObjects(@"new name", [lift effectiveName], @"");
}

@end