#import "JLift.h"
#import "Migrate13to14Tests.h"
#import "Migrate14to15Tests.h"
#import "JDataHelper.h"
#import "JFTOSetStore.h"
#import "Migrate14to15.h"
#import "JFTOLiftStore.h"

@implementation Migrate14to15Tests

- (void)testFindsLiftUuids {
    [[JLiftStore instance] empty];
    [[JFTOLiftStore instance] empty];
    JLift *lift1 = [[JLiftStore instance] create];
    JLift *lift2 = [[JFTOLiftStore instance] create];
    JLift *lift3 = [[JFTOLiftStore instance] create];
    [[JLiftStore instance] sync];
    [[JFTOLiftStore instance] sync];

    NSArray *uuids = [[Migrate14to15 new] getAllUuids];
    STAssertTrue([uuids containsObject:lift1.uuid], @"");
    STAssertTrue([uuids containsObject:lift2.uuid], @"");
    STAssertTrue([uuids containsObject:lift3.uuid], @"");
}

- (void)testRemovesDeadLiftsFromFtoSet {
    NSDictionary *setWithDeadLift = @{
            @"uuid" : @"1",
            @"reps" : @5,
            @"maxReps" : @0,
            @"percentage" : @50,
            @"lift" : @"bad-data",
            @"warmup" : @0,
            @"amrap" : @0,
            @"optional" : @0,
            @"assistance" : @0
    };

    NSDictionary *setWithGoodLift = @{
            @"uuid" : @"2",
            @"reps" : @5,
            @"maxReps" : @0,
            @"percentage" : @50,
            @"lift" : [[[JFTOLiftStore instance] first] uuid],
            @"warmup" : @0,
            @"amrap" : @0,
            @"optional" : @0,
            @"assistance" : @0
    };
    [JDataHelper write:[JFTOSetStore instance] values:@[setWithDeadLift, setWithGoodLift]];

    [[Migrate14to15 new] run];

    NSArray *values = [JDataHelper read:[JFTOSetStore instance]];
    STAssertEquals(values[0][@"lift"], [NSNull new], @"");
    STAssertFalse(values[1][@"lift"] == nil, @"");

    //assert does not crash
    [[JFTOSetStore instance] load];
}

@end