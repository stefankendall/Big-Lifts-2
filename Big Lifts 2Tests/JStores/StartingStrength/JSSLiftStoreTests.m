#import "JSSLiftStoreTests.h"
#import "JSSLiftStore.h"
#import "JSSLift.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "JSet.h"
#import "JSetStore.h"
#import "JWorkoutStore.h"
#import "JWorkout.h"

@implementation JSSLiftStoreTests

- (void)testSetsUpDefaultLifts {
    STAssertEquals([[JSSLiftStore instance] count], 5, @"");
}

- (void)testDefaultLiftsAreOrdered {
    JSSLiftStore *store = [JSSLiftStore instance];
    NSArray *lifts = [store findAll];
    STAssertTrue([[lifts[0] performSelector:@ selector(name)] isEqualToString:@"Bench"], @"");
    STAssertTrue([[lifts[1] performSelector:@ selector(name)] isEqualToString:@"Deadlift"], @"");
    STAssertTrue([[lifts[2] performSelector:@ selector(name)] isEqualToString:@"Power Clean"], @"");
    STAssertTrue([[lifts[3] performSelector:@ selector(name)] isEqualToString:@"Press"], @"");
    STAssertTrue([[lifts[4] performSelector:@ selector(name)] isEqualToString:@"Squat"], @"");
}

- (void)testLiftsCanBeFoundByName {
    JSSLiftStore *store = [JSSLiftStore instance];
    JSSLift *lift = [store find:@"name" value:@"Bench"];
    STAssertNotNil(lift, @"");
}

- (void)testLiftsGetIncrements {
    JSSLiftStore *store = [JSSLiftStore instance];
    JSSLift *lift = [store find:@"name" value:@"Bench"];
    STAssertEqualObjects(lift.increment, N(5), @"");
}

- (void)testUnitChangeDropsIncrements {
    JSSLiftStore *store = [JSSLiftStore instance];
    JSSLift *lift = [store find:@"name" value:@"Bench"];
    JSettings *settings = [[JSettingsStore instance] first];
    settings.units = @"kg";
    [[JSSLiftStore instance] adjustForKg];
    STAssertEqualObjects(lift.increment, N(2), @"");
}

- (void)testAddMissingLiftsAddsLifts {
    JSSLiftStore *store = [JSSLiftStore instance];
    [store addMissingLifts:@[@"Back Extension"]];
    STAssertEquals([[JSSLiftStore instance] count], 6, @"");
    JSSLift *lift = [[JSSLiftStore instance] find:@"name" value:@"Back Extension"];
    STAssertNotNil(lift, @"");
    STAssertEqualObjects(lift.order, @5, @"");
}

- (void)testAddMissingLiftsHonorsUnits {
    JSettings *settings = [[JSettingsStore instance] first];
    settings.units = @"kg";

    JSSLiftStore *store = [JSSLiftStore instance];
    [store remove:[store find:@"name" value:@"Power Clean"]];
    [store addMissingLifts:@[@"Power Clean"]];
    JSSLift *lift = [[JSSLiftStore instance] find:@"name" value:@"Power Clean"];
    STAssertEqualObjects(lift.increment, N(2), @"");
}

- (void)testSerializesNan {
    JSSLift *lift = [[JSSLiftStore instance] find:@"name" value:@"Power Clean"];
    lift.weight = [NSDecimalNumber notANumber];
    [[JSSLiftStore instance] serialize];
}

- (void)testRemoveExtraLifts {
    JSSLiftStore *store = [JSSLiftStore instance];
    [store removeExtraLifts:@[@"Power Clean"]];
    STAssertEquals([store count], 1, @"");
}

- (void)testRemovesDeadSetsWhenSsLiftsChange {
    JSSLift *bench = [[JSSLiftStore instance] find:@"name" value:@"Squat"];
    JSet *set = [[JSetStore instance] create];
    set.lift = bench;

    [[JWorkoutStore instance] empty];
    JWorkout *workout = [[JWorkoutStore instance] create];

    [workout addSet:set];

    [[JSSLiftStore instance] removeExtraLifts:@[@"Bench"]];
    STAssertEquals((int) [workout.sets count], 0, @"");
}

@end