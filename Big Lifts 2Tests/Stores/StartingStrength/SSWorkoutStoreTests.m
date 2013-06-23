#import <SenTestingKit/SenTestingKit.h>
#import "SSWorkoutStore.h"
#import "SSWorkoutStoreTests.h"
#import "SSWorkout.h"
#import "SSLiftStore.h"
#import "SSLift.h"
#import "Workout.h"
#import "Set.h"

@implementation SSWorkoutStoreTests

- (void)testSetsUpDefaultLifts {
    STAssertEquals([[SSWorkoutStore instance] count], 2, @"");
    SSWorkout *workoutA = [[SSWorkoutStore instance] atIndex:0];
    SSWorkout *workoutB = [[SSWorkoutStore instance] atIndex:1];

    STAssertTrue([workoutA.name isEqualToString:@"A"], @"");
    STAssertTrue([workoutB.name isEqualToString:@"B"], @"");

    STAssertEquals([workoutA.workouts count], (NSUInteger) 3, @"");
    STAssertEquals([workoutB.workouts count], (NSUInteger) 3, @"");
}

- (void)testLiftsCanBeReordered {
    SSWorkout *workoutA = [[SSWorkoutStore instance] atIndex:0];
    [workoutA.workouts exchangeObjectAtIndex:0 withObjectAtIndex:1];

    SSWorkout *savedWorkout = [[SSWorkoutStore instance] atIndex:0];
    Workout *workout = savedWorkout.workouts[0];
    SSLift *lift = (SSLift *) ((Set *) workout.sets[0]).lift;
    STAssertTrue([lift.name isEqualToString:@"Bench"], @"");
}

- (void)testSyncsToSsLiftsWeights {
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    Workout *workout = ssWorkout.workouts[0];
    Set *set = workout.sets[0];
    SSLift *lift = (SSLift *) set.lift;
    lift.weight = [NSDecimalNumber decimalNumberWithString:@"200"];
    [[SSWorkoutStore instance] syncSetsToLiftWeights];
    STAssertEquals(set.weight.doubleValue, 200.0, @"");
}

- (void)testIncrementsAssociatedLifts {
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    SSLift *squat = [[SSLiftStore instance] find:@"name" value:@"Squat"];
    squat.weight = [NSDecimalNumber decimalNumberWithString:@"200"];
    [[SSWorkoutStore instance] incrementWeights:ssWorkout];
    STAssertEquals([squat.weight doubleValue], 210.0, @"");
}

- (void)testSwitchToNovice {
    [[SSWorkoutStore instance] setupVariant:@"Novice"];
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] last];
    Workout *workout = ssWorkout.workouts[2];
    Set *firstSet = workout.sets[0];
    STAssertEqualObjects(firstSet.lift.name, @"Deadlift", @"");
}

- (void)testSwitchToOnusWunsler {
    [[SSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    STAssertEquals([[SSWorkoutStore instance] count], 3, @"");
}

- (void)testCreatesBackExtensionForOnusWunsler {
    [[SSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    [[SSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    SSLift *lift = [[SSLiftStore instance] find:@"name" value:@"Back Extension"];
    STAssertNotNil(lift, @"");
    STAssertEquals([[SSLiftStore instance] count], 6, @"");
}

- (void) testRemovesBackExtensionWhenNotOnusWunsler {
    [[SSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    [[SSWorkoutStore instance] setupVariant:@"Standard"];
    STAssertEquals([[SSLiftStore instance] count], 5, @"");
}

@end