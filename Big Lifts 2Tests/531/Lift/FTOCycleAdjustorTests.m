#import "FTOCycleAdjustorTests.h"
#import "FTOCycleAdjustor.h"
#import "FTOWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "FTOWorkout.h"
#import "FTOVariantStore.h"
#import "FTOVariant.h"

@implementation FTOCycleAdjustorTests

- (void)testDetectsCycleNeedingToAdjust {
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *ftoWorkout) {
        ftoWorkout.done = YES;
    }];
    STAssertTrue([[FTOCycleAdjustor new] cycleNeedsToIncrement], @"");
}

- (void)testDetectsCycleNotNeedingToAdjust {
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *ftoWorkout) {
        ftoWorkout.done = YES;
    }];
    [[[FTOWorkoutStore instance] first] setDone:NO];
    STAssertFalse([[FTOCycleAdjustor new] cycleNeedsToIncrement], @"");
}

- (void)testMidCycleSixWeek {
    [[[FTOVariantStore instance] first] setName:FTO_VARIANT_SIX_WEEK];
    [[FTOWorkoutStore instance] switchTemplate];

    [self setupMidSixWeekLiftsDone];
    STAssertTrue([[FTOCycleAdjustor new] midPointOfSixWeekCycle], @"");
}

- (void)testMidCycleSixWeekDoesntTriggerPastMid {
    [[[FTOVariantStore instance] first] setName:FTO_VARIANT_SIX_WEEK];
    [[FTOWorkoutStore instance] switchTemplate];

    [self setupMidSixWeekLiftsDone];
    FTOWorkout *firstWorkoutPastCycle = [[[FTOWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:4]] firstObject];
    firstWorkoutPastCycle.done = YES;
    STAssertFalse([[FTOCycleAdjustor new] midPointOfSixWeekCycle], @"");
}

- (void)testMidCycleSixWeekDoesntTriggerForNonSixWeek {
    [self setupMidSixWeekLiftsDone];
    STAssertFalse([[FTOCycleAdjustor new] midPointOfSixWeekCycle], @"");
}

- (void)setupMidSixWeekLiftsDone {
    for (int week = 1; week <= 3; week++) {
        [[[FTOWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:week]] each:^(FTOWorkout *workout) {
            workout.done = YES;
        }];
    }
}


@end