#import "JSSWorkoutStore.h"
#import "JSSWorkoutStoreTests.h"
#import "JSSWorkout.h"
#import "JSSLiftStore.h"
#import "JSSLift.h"
#import "JWorkout.h"
#import "JSet.h"
#import "NSArray+Enumerable.h"
#import "JSSStateStore.h"
#import "JSSState.h"
#import "JWorkoutStore.h"
#import "JSetStore.h"

@implementation JSSWorkoutStoreTests

- (void)testDoesNotLeakWorkouts {
    int workoutCount = [[JWorkoutStore instance] count];
    [[JSSWorkoutStore instance] setupVariant:@"Standard"];
    STAssertEquals(workoutCount, [[JWorkoutStore instance] count], @"");
}

- (void)testDoesNotLeakSets {
    int setCount = [[JSetStore instance] count];
    [[JSSWorkoutStore instance] setupVariant:@"Standard"];
    [[JSSWorkoutStore instance] setupVariant:@"Novice"];
    [[JSSWorkoutStore instance] setupVariant:@"Standard"];
    STAssertEquals(setCount, [[JSetStore instance] count], @"");
}

- (void)testDoesNotCreateAnonymousLifts {
    [[JSSWorkoutStore instance] setupVariant:@"Novice"];
    for (JSSLift *lift in [[JSSLiftStore instance] findAll]) {
        STAssertFalse(lift.uuid == nil, @"");
    }
}

- (void)testDoesNotLeaveDeadLiftsInSetsWhenSwitchingToNovice {
    [[JSSWorkoutStore instance] setupVariant:@"Novice"];
    for (JSSLift *lift in [[JSSLiftStore instance] findAll]) {
        STAssertFalse([lift.name isEqualToString:@"Power Clean"], @"");
    }
    for (JSet *set in [[JSetStore instance] findAll]) {
        STAssertFalse([set.lift isDead], @"");
    }
}

- (void)testSetupVariantClearsStateStore {
    JSSState *state = [[JSSStateStore instance] first];
    state.lastWorkout = [[JSSWorkoutStore instance] first];
    [[JSSWorkoutStore instance] setupVariant:@"Novice"];
    STAssertNil(state.lastWorkout, @"");
}

- (void)testSetsUpDefaultLifts {
    STAssertEquals([[JSSWorkoutStore instance] count], 2, @"");
    JSSWorkout *workoutA = [[JSSWorkoutStore instance] atIndex:0];
    JSSWorkout *workoutB = [[JSSWorkoutStore instance] atIndex:1];

    STAssertTrue([workoutA.name isEqualToString:@"A"], @"");
    STAssertTrue([workoutB.name isEqualToString:@"B"], @"");

    STAssertEquals([workoutA.workouts count], (NSUInteger) 3, @"");
    STAssertEquals([workoutB.workouts count], (NSUInteger) 3, @"");
}

- (void)testLiftsCanBeReordered {
    JSSWorkout *workoutA = [[JSSWorkoutStore instance] atIndex:0];
    [workoutA.workouts exchangeObjectAtIndex:0 withObjectAtIndex:1];

    JSSWorkout *savedWorkout = [[JSSWorkoutStore instance] atIndex:0];
    JWorkout *workout = savedWorkout.workouts[0];
    JSSLift *lift = (JSSLift *) ((JSet *) workout.sets[0]).lift;
    STAssertTrue([lift.name isEqualToString:@"Bench"], @"");
}

- (void)testIncrementsAssociatedLifts {
    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JSSLift *squat = [[JSSLiftStore instance] find:@"name" value:@"Squat"];
    squat.weight = N(200);
    [[JSSWorkoutStore instance] incrementWeights:ssWorkout];
    STAssertEqualObjects(squat.weight, N(210), @"");
}

- (void)testSwitchToNovice {
    [[JSSWorkoutStore instance] setupVariant:@"Novice"];
    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] last];
    JWorkout *workout = ssWorkout.workouts[2];
    JSet *firstSet = workout.sets[0];
    STAssertEqualObjects(firstSet.lift.name, @"Deadlift", @"");
}

- (void)testSwitchToOnusWunsler {
    [[JSSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    STAssertEquals([[JSSWorkoutStore instance] count], 3, @"");
}

- (void)testCreatesLiftsForOnusWunsler {
    [[JSSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    [[JSSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    STAssertNotNil([[JSSLiftStore instance] find:@"name" value:@"Back Extension"], @"");
    STAssertNotNil([[JSSLiftStore instance] find:@"name" value:@"Chin-ups"], @"");
    STAssertEquals([[JSSLiftStore instance] count], 7, @"");
}

- (void)testRemovesBackExtensionWhenNotOnusWunsler {
    [[JSSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    [[JSSWorkoutStore instance] setupVariant:@"Standard"];
    STAssertEquals([[JSSLiftStore instance] count], 5, @"");
}

- (void)testSetupSsWarmupStandard {
    [[JSSWorkoutStore instance] setupVariant:@"Standard"];
    [[JSSWorkoutStore instance] addWarmup];
    JSSWorkout *workoutA = [[JSSWorkoutStore instance] find:@"name" value:@"A"];
    JWorkout *squatWorkout = [workoutA.workouts detect:^BOOL(JWorkout *workout) {
        JSet *set = workout.sets[0];
        return [set.lift.name isEqualToString:@"Squat"];
    }];

    STAssertEquals((int) [squatWorkout.sets count], 8, @"");
}

- (void)testActiveWorkoutForPracticalProgramming {
    [[JSSWorkoutStore instance] setupVariant:@"Practical Programming"];
    JSSWorkout *workout = [[JSSWorkoutStore instance] activeWorkoutFor:@"A"];
    JSet *set = [[[workout.workouts lastObject] sets] firstObject];
    STAssertEqualObjects(set.lift.name, @"Chin-ups", @"");

    JSSState *state = [[JSSStateStore instance] first];
    state.workoutAAlternation = @1;

    workout = [[JSSWorkoutStore instance] activeWorkoutFor:@"A"];
    set = [[[workout.workouts lastObject] sets] firstObject];
    STAssertEqualObjects(set.lift.name, @"Pull-ups", @"");
}

- (void)testActiveWorkoutPracticalProgrammingBenchRotation {
    [[JSSWorkoutStore instance] setupVariant:@"Practical Programming"];
    JSSWorkout *workout = [[JSSWorkoutStore instance] activeWorkoutFor:@"A"];
    JSet *set = [[workout.workouts[1] sets] lastObject];
    STAssertEqualObjects(set.lift.name, @"Bench", @"");

    JSSState *state = [[JSSStateStore instance] first];
    state.lastWorkout = workout;

    workout = [[JSSWorkoutStore instance] activeWorkoutFor:@"A"];
    set = [[workout.workouts[1] sets] lastObject];
    STAssertEqualObjects(set.lift.name, @"Press", @"");
}

- (void)testHandlesIncrementForNoIncrementLifts {
    [[JSSWorkoutStore instance] setupVariant:@"Practical Programming"];
    JSSWorkout *workout = [[JSSWorkoutStore instance] activeWorkoutFor:@"A"];
    JSet *chinups = [[[workout.workouts lastObject] sets] firstObject];
    [[JSSWorkoutStore instance] incrementWeights:workout];
    STAssertEqualObjects([chinups effectiveWeight], N(0), @"");
}

- (void)testSetsUsesBarCorrectlyForLifts {
    [[JSSWorkoutStore instance] setupVariant:@"Practical Programming"];
    JSSLift *chinUps = [[JSSLiftStore instance] find:@"name" value:@"Chin-ups"];
    JSSLift *pullUps = [[JSSLiftStore instance] find:@"name" value:@"Pull-ups"];
    JSSLift *squat = [[JSSLiftStore instance] find:@"name" value:@"Squat"];
    STAssertTrue(squat.usesBar, @"");
    STAssertFalse(chinUps.usesBar, @"");
    STAssertFalse(pullUps.usesBar, @"");

    [[JSSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    JSSLift *backExtensions = [[JSSLiftStore instance] find:@"name" value:@"Back Extensions"];
    STAssertFalse(backExtensions.usesBar, @"");
}

- (void)testReplacesBenchWithPress {
    [[JSSWorkoutStore instance] setupVariant:@"Practical Programming"];
    JSSWorkout *workout = [[JSSWorkoutStore instance] activeWorkoutFor:@"A"];
    JSet *set = [[workout.workouts[1] sets] firstObject];
    STAssertEqualObjects(set.lift.name, @"Bench", @"");

    [[JSSWorkoutStore instance] replaceBenchWithPress:workout];
    set = [[workout.workouts[1] sets] firstObject];
    STAssertEqualObjects(set.lift.name, @"Press", @"");
}

- (void)testHandlesStandardPlanWithAlternation {
    [[[JSSStateStore instance] first] setWorkoutAAlternation:@1];
    JSSWorkout *workout = [[JSSWorkoutStore instance] activeWorkoutFor:@"A"];
    STAssertNotNil(workout, @"");
}

@end