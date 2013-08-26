#import "FTOBoringButBigAssistanceTests.h"
#import "FTOBoringButBigAssistance.h"
#import "FTOWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "FTOBBBPercentageStore.h"

@implementation FTOBoringButBigAssistanceTests

- (void) testAddingBoringButBigRemovesAmrap {
    [[FTOBoringButBigAssistance new] setup];

    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *workout) {
        STAssertFalse([[[workout.workout sets] lastObject] amrap], @"");
    }];
}

- (void) testAddsBoringButBigSets {
    [[FTOBoringButBigAssistance new] setup];
    FTOWorkout *workoutInWeek1 = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEquals([workoutInWeek1.workout.sets count], 11U, @"");
    Set * boringSet = workoutInWeek1.workout.sets[6];
    STAssertEqualObjects(boringSet.percentage, N(50), @"");
    STAssertEqualObjects(boringSet.reps, @10, @"");

    FTOWorkout *workoutInWeek4 = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@4][0];
    STAssertEquals([workoutInWeek4.workout.sets count], 9U, @"");
}

- (void) testUsesBbbPercentage {
    [[[FTOBBBPercentageStore instance] first] setPercentage: N(60)];
    [[FTOBoringButBigAssistance new] setup];
    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] first];
    STAssertEqualObjects([[ftoWorkout.workout.sets lastObject] percentage], N(60), @"");
}

@end