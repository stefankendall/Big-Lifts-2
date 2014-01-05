#import "JSVWorkoutStoreTests.h"
#import "JSVWorkoutStore.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "JSVWorkout.h"
#import "JWorkout.h"
#import "JSet.h"

@implementation JSVWorkoutStoreTests

- (void)testChangesIncrementsForKg {
    JSVWorkoutStore *store = [JSVWorkoutStore instance];
    STAssertEqualObjects([store incrementInLbsOrKg:N(30)], N(30), @"");
    STAssertEqualObjects([store incrementInLbsOrKg:N(20)], N(20), @"");

    [[[JSettingsStore instance] first] setUnits:@"kg"];
    STAssertEqualObjects([store incrementInLbsOrKg:N(30)], N(14), @"");
    STAssertEqualObjects([store incrementInLbsOrKg:N(20)], N(9), @"");
}

- (void)testAdjustsForKg {
    [[[JSettingsStore instance] first] setUnits:@"kg"];
    [[JSVWorkoutStore instance] adjustForKg];

    JSVWorkout *cycle2week2day1 = [[JSVWorkoutStore instance] findAllWhere:@"cycle" value:@2][4];
    STAssertEqualObjects(cycle2week2day1.weightAdd, N(9), @"");
}

- (void)testAssociatesLiftsToSets {
    JSVWorkout *cycle1week1day1 = [[JSVWorkoutStore instance] findAllWhere:@"cycle" value:@1][0];
    JSet *set = cycle1week1day1.workout.sets[0];
    STAssertNotNil(set, @"");
    STAssertNotNil(set.lift, @"");
}

@end