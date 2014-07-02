#import "JSetLog.h"
#import "JSetTests.h"
#import "JSet.h"
#import "JSetStore.h"
#import "JLiftStore.h"
#import "JLift.h"
#import "JDataHelper.h"
#import "JFTOSetStore.h"
#import "Migrate14to15.h"

@implementation JSetTests

- (void)testSerializesAndDeserializesSets {
    [[JSetStore instance] empty];
    JLift *lift = [[JLiftStore instance] create];
    lift.name = @"Bench";
    lift.weight = N(200);
    lift.usesBar = YES;

    JSet *set = [[JSetStore instance] create];
    set.lift = lift;
    set.reps = @5;
    set.warmup = NO;
    set.amrap = NO;
    set.optional = NO;
    set.assistance = NO;
    set.percentage = N(90);

    NSArray *serialized = [[JSetStore instance] serialize];
    JSet *deserializedSet = (id) [[JSetStore instance] deserializeObject:serialized[0]];
    STAssertEqualObjects(deserializedSet.reps, @5, @"");
    STAssertEqualObjects(deserializedSet.percentage, N(90), @"");
    STAssertEquals(deserializedSet.lift, lift, @"");
}

- (void)testCanDeserializeSetsWithoutMaxRepsAfterMigration {
    NSDictionary *dictionary = @{
            @"uuid" : @"1EDE8EA6-EB8F-4341-ABFB-90EA3605D743",
            @"lift" : [NSNull new],
            @"warmup" : @0,
            @"amrap" : @0,
            @"optional" : @0,
            @"percentage" : N(50),
            @"assistance" : @1,
            @"reps" : @10
    };
    [JDataHelper write:[JFTOSetStore instance] values:@[dictionary]];
    [[Migrate14to15 new] run];
    [[JFTOSetStore instance] load];
    STAssertEquals([[JFTOSetStore instance] count], 1, @"");
}

- (void)testHandlesNilPercentages {
    JSet *set = [[JSetStore instance] create];
    set.percentage = nil;
    set.lift = [[JLiftStore instance] create];
    set.lift.weight = N(100);

    STAssertEqualObjects([set effectiveWeight], N(0), @"");
}

@end