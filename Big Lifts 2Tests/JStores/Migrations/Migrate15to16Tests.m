#import "Migrate15to16Tests.h"
#import "JFTOSSTLiftStore.h"
#import "JFTOSSTLift.h"
#import "Migrate15to16.h"

@implementation Migrate15to16Tests

- (void)testSetsUsesBarToTrueForSstLifts {
    for (JFTOSSTLift *lift in [[JFTOSSTLiftStore instance] findAll]) {
        lift.usesBar = NO;
    }
    [[Migrate15to16 new] run];
    [[JFTOSSTLiftStore instance] load:nil];
    STAssertEquals([[JFTOSSTLiftStore instance] count], 4, @"");
    for (JFTOSSTLift *lift in [[JFTOSSTLiftStore instance] findAll]) {
        STAssertTrue(lift.usesBar, @"");
    }
}

@end