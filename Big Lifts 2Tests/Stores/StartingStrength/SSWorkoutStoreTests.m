#import <SenTestingKit/SenTestingKit.h>
#import "SSWorkoutStore.h"
#import "SSWorkoutStoreTests.h"
#import "SSWorkout.h"
#import "SSLiftStore.h"
#import "SSLift.h"
#import "ContextManager.h"

@implementation SSWorkoutStoreTests

- (void)setUp {
    [super setUp];
    [[SSLiftStore instance] empty];
    [[SSLiftStore instance] setupDefaults];

    [[SSWorkoutStore instance] empty];
    [[SSWorkoutStore instance] setupDefaults];
}

- (void)testSetsUpDefaultLifts {
    STAssertEquals([[SSWorkoutStore instance] count], 2, @"");
    SSWorkout * workoutA = [[SSWorkoutStore instance] atIndex:0];
    SSWorkout * workoutB = [[SSWorkoutStore instance] atIndex:1];

    STAssertTrue([workoutA.name isEqualToString:@"A"], @"");
    STAssertTrue([workoutB.name isEqualToString:@"B"], @"");

    STAssertEquals([workoutA.lifts count], (NSUInteger) 3, @"");
    STAssertEquals([workoutB.lifts count], (NSUInteger) 3, @"");
}

- (void) testLiftsCanBeReordered {
    SSWorkout * workoutA = [[SSWorkoutStore instance] atIndex:0];
    [workoutA.lifts exchangeObjectAtIndex:0 withObjectAtIndex:1];

    SSWorkout * savedWorkout = [[SSWorkoutStore instance] atIndex:0];
    SSLift *lift = savedWorkout.lifts[0];
    STAssertTrue([lift.name isEqualToString:@"Bench"], @"");
}

@end