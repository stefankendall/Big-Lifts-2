#import "FTOWorkoutStoreTests.h"
#import "BLStore.h"
#import "FTOWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"
#import "FTOSet.h"
#import "FTOLiftStore.h"
#import "FTOVariantStore.h"
#import "FTOVariant.h"
#import "FTOAssistanceStore.h"
#import "FTOAssistance.h"
#import "FTOSettingsStore.h"
#import "FTOSettings.h"

@implementation FTOWorkoutStoreTests

- (void)testSetsUpDefaultWorkouts {
    NSArray *ftoWorkouts = [[FTOWorkoutStore instance] findAll];
    STAssertEquals( [ftoWorkouts count], 16U, @"");

    NSArray *liftNames = [ftoWorkouts collect:^NSString *(FTOWorkout *ftoWorkout) {
        Set *firstSet = ftoWorkout.workout.orderedSets[0];
        return firstSet.lift.name;
    }];

    STAssertTrue([liftNames containsObject:@"Bench"], @"");
    STAssertTrue([liftNames containsObject:@"Press"], @"");
    STAssertTrue([liftNames containsObject:@"Deadlift"], @"");
    STAssertTrue([liftNames containsObject:@"Squat"], @"");

    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertTrue([ftoWorkout.workout.orderedSets[0] isKindOfClass:FTOSet.class], @"");
    FTOSet *lastSet = [ftoWorkout.workout.orderedSets lastObject];
    STAssertTrue(lastSet.amrap, @"");
}

- (void)testSetsUpWorkoutsNonDefaultLifts {
    [[[FTOLiftStore instance] first] setName:@"Power Clean"];
    [[FTOWorkoutStore instance] switchTemplate];
    NSArray *ftoWorkouts = [[FTOWorkoutStore instance] findAll];
    NSArray *liftNames = [ftoWorkouts collect:^NSString *(FTOWorkout *ftoWorkout) {
        Set *firstSet = ftoWorkout.workout.orderedSets[0];
        return firstSet.lift.name;
    }];

    STAssertTrue([liftNames containsObject:@"Power Clean"], @"");
}

- (void)testMarksDeloadWeeks {
    FTOWorkout *week1Workout = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertFalse(week1Workout.deload, @"");

    FTOWorkout *week4Workout = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@4][0];
    STAssertTrue(week4Workout.deload, @"");
}

- (void)testFindsDoneLiftsByWeek {
    FTOWorkout *week1Workout1 = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    Lift *firstLift = [[week1Workout1.workout.orderedSets firstObject] lift];
    week1Workout1.done = YES;

    STAssertEqualObjects([[FTOWorkoutStore instance] getDoneLiftsByWeek], @{@1 : @[firstLift]}, @"");
}

- (void)testTransfersDoneStatusWhenSwitchingTemplates {
    FTOWorkout *week1Workout1 = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    week1Workout1.done = YES;

    [[FTOVariantStore instance] changeTo:FTO_VARIANT_PYRAMID];

    week1Workout1 = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertTrue(week1Workout1.done, @"");
    FTOWorkout *week1Workout2 = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][1];
    STAssertFalse(week1Workout2.done, @"");
}

- (void)testReappliesAssistanceWhenSwitchingTemplates {
    [[FTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    [[FTOVariantStore instance] changeTo:FTO_VARIANT_PYRAMID];
    [[FTOVariantStore instance] changeTo:FTO_VARIANT_STANDARD];
    FTOWorkout *week1Workout1 = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEquals([week1Workout1.workout.orderedSets count], 11U, @"");
}

- (void)testDoesNotAddWarmupWhenSwitchingTemplateIfItsOff {
    [[[FTOSettingsStore instance] first] setWarmupEnabled:NO];
    [[FTOWorkoutStore instance] switchTemplate];
    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] first];
    STAssertEquals([ftoWorkout.workout.orderedSets count], 3U, @"");
}

@end