#import "FTOBoringButBigAssistanceTests.h"
#import "FTOBoringButBigAssistance.h"
#import "FTOWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "FTOBoringButBigStore.h"
#import "SetData.h"
#import "FTOBoringButBig.h"

@implementation FTOBoringButBigAssistanceTests

- (void)testAddingBoringButBigRemovesAmrap {
    [[FTOBoringButBigAssistance new] setup];

    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *workout) {
        STAssertFalse([[[workout.workout sets] lastObject] amrap], @"");
    }];
}

- (void)testAddsBoringButBigSets {
    [[FTOBoringButBigAssistance new] setup];
    FTOWorkout *workoutInWeek1 = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEquals([workoutInWeek1.workout.orderedSets count], 11U, @"");
    Set *boringSet = workoutInWeek1.workout.orderedSets[6];
    STAssertEqualObjects(boringSet.percentage, N(50), @"");
    STAssertEqualObjects(boringSet.reps, @10, @"");

    FTOWorkout *workoutInWeek4 = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@4][0];
    STAssertEquals([workoutInWeek4.workout.orderedSets count], 6U, @"");
}

- (void)testUsesBbbPercentage {
    [[[FTOBoringButBigStore instance] first] setPercentage:N(60)];
    [[FTOBoringButBigAssistance new] setup];
    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEqualObjects([[ftoWorkout.workout.orderedSets lastObject] percentage], N(60), @"");
}

- (void)testIncrementsBbbPercentageIfChallengeOn {
    FTOBoringButBig *bbb = [[FTOBoringButBigStore instance] first];
    [bbb setPercentage:N(60)];
    [bbb setThreeMonthChallenge:YES];
    [[FTOBoringButBigAssistance new] cycleChange];
    [[FTOBoringButBigAssistance new] setup];

    STAssertEqualObjects([[[FTOBoringButBigStore instance] first] percentage], N(70), @"");
    STAssertEqualObjects([[[[[[FTOWorkoutStore instance] first] workout] sets] lastObject] percentage], N(70), @"");
}

- (void)testDoesNotIncrementUnknownPercentageIfChallengeOn {
    FTOBoringButBig *bbb = [[FTOBoringButBigStore instance] first];
    [bbb setPercentage:N(65)];
    [bbb setThreeMonthChallenge:YES];
    [[FTOBoringButBigAssistance new] cycleChange];
    [[FTOBoringButBigAssistance new] setup];

    STAssertEqualObjects(bbb.percentage, N(65), @"");
}

@end