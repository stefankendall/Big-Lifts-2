#import "SenTestCase+ControllerTestAdditions.h"
#import "JFTOBoringButBigAssistanceTests.h"
#import "JFTOWorkoutStore.h"
#import "JFTOWorkout.h"
#import "JFTOBoringButBigAssistance.h"
#import "JWorkout.h"
#import "JSet.h"
#import "JFTOBoringButBig.h"
#import "JFTOBoringButBigStore.h"
#import "NSArray+Enumerable.h"
#import "JFTOLiftStore.h"
#import "JFTOBoringButBigLift.h"
#import "JFTOBoringButBigLiftStore.h"

@implementation JFTOBoringButBigAssistanceTests

- (void)testAddingBoringButBigRemovesAmrap {
    [[JFTOBoringButBigAssistance new] setup];

    [[[JFTOWorkoutStore instance] findAll] each:^(JFTOWorkout *workout) {
        STAssertFalse([[workout.workout.orderedSets lastObject] amrap], @"");
    }];
}

- (void) testDoesNotCrashWhenAWorkoutIsEmpty {
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] first];
    ftoWorkout.workout.sets = [@[] mutableCopy];
    [[JFTOBoringButBigAssistance new] setup];
    STAssertEquals((int) [ftoWorkout.workout.sets count], 0, @"");
}

- (void)testAddsBoringButBigSets {
    [[JFTOBoringButBigAssistance new] setup];
    JFTOWorkout *workoutInWeek1 = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEquals((int) [workoutInWeek1.workout.orderedSets count], 11, @"");
    JSet *boringSet = workoutInWeek1.workout.orderedSets[6];
    STAssertEqualObjects(boringSet.percentage, N(50), @"");
    STAssertEqualObjects(boringSet.reps, @10, @"");

    JFTOWorkout *workoutInWeek4 = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@4][0];
    STAssertEquals((int) [workoutInWeek4.workout.orderedSets count], 6, @"");
}

- (void)testCanUseDifferentLifts {
    JFTOBoringButBigLift *bbbLift = [[JFTOBoringButBigLiftStore instance] first];
    JFTOLift *deadlift = [[JFTOLiftStore instance] find:@"name" value: @"Deadlift"];
    bbbLift.boringLift = deadlift;
    [[JFTOBoringButBigAssistance new] setup];

    JFTOWorkout *workoutInWeek1 = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    JSet *boringSet = workoutInWeek1.workout.orderedSets[6];
    STAssertEqualObjects(boringSet.lift, deadlift, @"");
}

- (void)testUsesBbbPercentage {
    [[[JFTOBoringButBigStore instance] first] setPercentage:N(60)];
    [[JFTOBoringButBigAssistance new] setup];
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEqualObjects([[ftoWorkout.workout.orderedSets lastObject] percentage], N(60), @"");
}

- (void)testIncrementsBbbPercentageIfChallengeOn {
    JFTOBoringButBig *bbb = [[JFTOBoringButBigStore instance] first];
    [bbb setPercentage:N(60)];
    [bbb setThreeMonthChallenge:YES];
    [[JFTOBoringButBigAssistance new] cycleChange];
    [[JFTOBoringButBigAssistance new] setup];

    STAssertEqualObjects([[[JFTOBoringButBigStore instance] first] percentage], N(70), @"");
    STAssertEqualObjects([[[[[[JFTOWorkoutStore instance] first] workout] sets] lastObject] percentage], N(70), @"");
}

- (void)testDoesNotIncrementUnknownPercentageIfChallengeOn {
    JFTOBoringButBig *bbb = [[JFTOBoringButBigStore instance] first];
    [bbb setPercentage:N(65)];
    [bbb setThreeMonthChallenge:YES];
    [[JFTOBoringButBigAssistance new] cycleChange];
    [[JFTOBoringButBigAssistance new] setup];

    STAssertEqualObjects(bbb.percentage, N(65), @"");
}

@end