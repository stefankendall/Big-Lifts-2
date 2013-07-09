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
}

- (void)testRoundsTo1 {
    Settings *settings = [[SettingsStore instance] first];
    settings.roundTo = N(1);
    STAssertEqualObjects([[WeightRounder new] round:N(166)], @166, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(166.3)], @166, @"");
    STAssertEqualObjects([[WeightRounder new] round:N(166.5)], @167, @"");
}

@end