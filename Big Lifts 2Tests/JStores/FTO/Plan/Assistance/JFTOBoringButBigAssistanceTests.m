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
#import "JFTOVariantStore.h"
#import "JFTOVariant.h"

@implementation JFTOBoringButBigAssistanceTests

- (void)testDoesNotCrashWhenAWorkoutIsEmpty {
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] first];
    ftoWorkout.workout.sets = [@[] mutableCopy];
    [[JFTOBoringButBigAssistance new] setup];
    STAssertEquals((int) [ftoWorkout.workout.sets count], 0, @"");
}

- (void)testAddsBoringButBigSets {
    [[JFTOBoringButBigAssistance new] setup];
    JFTOWorkout *workoutInWeek1 = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEquals((int) [workoutInWeek1.workout.sets count], 11, @"");
    JSet *boringSet = workoutInWeek1.workout.sets[6];
    STAssertEqualObjects(boringSet.percentage, N(50), @"");
    STAssertEqualObjects(boringSet.reps, @10, @"");

    JFTOWorkout *workoutInWeek4 = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@4][0];
    STAssertEquals((int) [workoutInWeek4.workout.sets count], 6, @"");
}

- (void)testCanUseDifferentLifts {
    JFTOBoringButBigLift *bbbLift = [[JFTOBoringButBigLiftStore instance] first];
    JFTOLift *deadlift = [[JFTOLiftStore instance] find:@"name" value:@"Deadlift"];
    bbbLift.boringLift = deadlift;
    [[JFTOBoringButBigAssistance new] setup];

    JFTOWorkout *workoutInWeek1 = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    JSet *boringSet = workoutInWeek1.workout.sets[6];
    STAssertEqualObjects(boringSet.lift, deadlift, @"");
}

- (void)testUsesBbbPercentage {
    [[[JFTOBoringButBigStore instance] first] setPercentage:N(60)];
    [[JFTOBoringButBigAssistance new] setup];
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEqualObjects([[ftoWorkout.workout.sets lastObject] percentage], N(60), @"");
}

- (void)testIncrementsBbbPercentageIfChallengeOn {
    JFTOBoringButBig *bbb = [[JFTOBoringButBigStore instance] first];
    [bbb setPercentage:N(60)];
    [bbb setThreeMonthChallenge:YES];
    [[JFTOBoringButBigAssistance new] cycleChange];

    STAssertEqualObjects([[[JFTOBoringButBigStore instance] first] percentage], N(70), @"");
    STAssertEqualObjects([[[[[[JFTOWorkoutStore instance] first] workout] sets] lastObject] percentage], N(70), @"");
}

- (void)testDoesNotIncrementUnknownPercentageIfChallengeOn {
    JFTOBoringButBig *bbb = [[JFTOBoringButBigStore instance] first];
    [bbb setPercentage:N(65)];
    [bbb setThreeMonthChallenge:YES];
    [[JFTOBoringButBigAssistance new] cycleChange];

    STAssertEqualObjects(bbb.percentage, N(65), @"");
}

- (void)testDoesNotRemoveAmrapFromCustom {
    [[JFTOVariantStore instance] changeTo:FTO_VARIANT_CUSTOM];
    NSArray *workoutsWithAmrap = [self findWorkoutsWithAmrap];
    STAssertEquals((int) [workoutsWithAmrap count], 12, @"");

    [[JFTOBoringButBigAssistance new] setup];

    workoutsWithAmrap = [self findWorkoutsWithAmrap];
    STAssertEquals((int) [workoutsWithAmrap count], 12, @"");
}

- (void)testDoesNotDuplicateAssistanceOnCycleChange {
    [[JFTOBoringButBigAssistance new] setup];
    [[JFTOBoringButBigAssistance new] cycleChange];
    JWorkout *workout = [[[JFTOWorkoutStore instance] first] workout];
    STAssertEquals((int) [workout.assistanceSets count], 5, @"");
}

- (NSArray *)findWorkoutsWithAmrap {
    NSArray *workoutsWithAmrap = [[[JFTOWorkoutStore instance] findAll] select:^BOOL(JFTOWorkout *jftoWorkout) {
        return [jftoWorkout.workout.sets detect:^BOOL(JSet *set) {
            return set.amrap;
        }] != nil;
    }];
    return workoutsWithAmrap;
}

@end