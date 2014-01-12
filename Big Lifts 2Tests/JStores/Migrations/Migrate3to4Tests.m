#import "Migrate3to4Tests.h"
#import "JBarStore.h"
#import "FTOCustomAssistanceEditLiftViewController.h"
#import "Migrate3to4.h"

@implementation Migrate3to4Tests

- (void)testMakesBarWeightNonNil {
    [[[JBarStore instance] first] setWeight:nil];
    [[Migrate3to4 new] run];
    STAssertEqualObjects([[[JBarStore instance] first] weight], N(0), @"");
}

@end