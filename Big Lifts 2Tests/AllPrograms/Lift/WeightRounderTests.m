#import "WeightRounderTests.h"
#import "WeightRounder.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation WeightRounderTests

- (void)testRoundsTo5ByDefault {
    STAssertEqualObjects([[WeightRounder new] round:N(165)], @165, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(166)], @165, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(168)], @170, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(167.5)], @170, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(167.3)], @165, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(85.4)], @85, @"");
}

- (void) testRoundsTo2p5 {
    [[[SettingsStore instance] first] setRoundTo: N(2.5)];
    STAssertEqualObjects([[WeightRounder new] round:N(81.24)], @80, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(82.5)], @82.5, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(83.75)], @85, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(85)], @85, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(86.25)], @87.5, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(87.5)], @87.5, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(87.6)], @87.5, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(88.75)], @90, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(90)], @90, @"");
}

- (void)testRoundsTo1 {
    [[[SettingsStore instance] first] setRoundTo: N(1)];
    STAssertEqualObjects([[WeightRounder new] round:N(166)], @166, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(166.3)], @166, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(166.5)], @167, @"");
}

@end