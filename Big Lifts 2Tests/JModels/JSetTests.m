#import "JSetLog.h"
#import "JSetTests.h"
#import "JSet.h"
#import "JSetStore.h"
#import "JLiftStore.h"
#import "JLift.h"

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

    NSArray *serialized = [[JSetStore instance] serializeAndCache];
    JSet *deserializedSet = (id) [[JSetStore instance] deserializeObject:serialized[0]];
    STAssertEqualObjects(deserializedSet.reps, @5, @"");
    STAssertEqualObjects(deserializedSet.percentage, N(90), @"");
    STAssertEquals(deserializedSet.lift, lift, @"");
}

- (void)testHandlesNilPercentages {
    JSet *set = [[JSetStore instance] create];
    set.percentage = nil;
    set.lift = [[JLiftStore instance] create];
    set.lift.weight = N(100);

    STAssertEqualObjects([set effectiveWeight], N(0), @"");
}

@end