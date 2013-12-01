#import "FTOCycleAdjustorTests.h"
#import "FTOCycleAdjustor.h"
#import "JFTOWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "JFTOVariantStore.h"
#import "JFTOWorkout.h"
#import "FTOVariant.h"

@implementation FTOCycleAdjustorTests

- (void)testDetectsCycleNeedingToAdjust {
    [[[JFTOWorkoutStore instance] findAll] each:^(JFTOWorkout *ftoWorkout) {
        ftoWorkout.done = YES;
    }];
    STAssertTrue([[FTOCycleAdjustor new] cycleNeedsToIncrement], @"");
}

- (void)testDetectsCycleNotNeedingToAdjust {
    [[[JFTOWorkoutStore instance] findAll] each:^(JFTOWorkout *ftoWorkout) {
        ftoWorkout.done = YES;
    }];
    [[[JFTOWorkoutStore instance] first] setDone:NO];
    STAssertFalse([[FTOCycleAdjustor new] cycleNeedsToIncrement], @"");
}

- (void)testMidCycleSixWeek {
    [[[JFTOVariantStore instance] first] setName:FTO_VARIANT_SIX_WEEK];
    [[JFTOWorkoutStore instance] switchTemplate];

    [self setupMidSixWeekLiftsDone];
    STAssertTrue([[FTOCycleAdjustor new] shouldIncrementLifts], @"");
}

- (void)testMidCycleSixWeekDoesntTriggerPastMid {
    [[[JFTOVariantStore instance] first] setName:FTO_VARIANT_SIX_WEEK];
    [[JFTOWorkoutStore instance] switchTemplate];

    [self setupMidSixWeekLiftsDone];
    JFTOWorkout *firstWorkoutPastCycle = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:4]] firstObject];
    firstWorkoutPastCycle.done = YES;
    STAssertFalse([[FTOCycleAdjustor new] shouldIncrementLifts], @"");
}

- (void)testMidCycleSixWeekDoesntTriggerForNonSixWeek {
    [self setupMidSixWeekLiftsDone];
    STAssertFalse([[FTOCycleAdjustor new] shouldIncrementLifts], @"");
}

- (void)setupMidSixWeekLiftsDone {
    for (int week = 1; week <= 3; week++) {
        [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:[NSNumber numberWithInt:week]] each:^(JFTOWorkout *workout) {
            workout.done = YES;
        }];
    }
}


@end