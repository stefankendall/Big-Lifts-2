#import "FTOCycleAdjustorTests.h"
#import "FTOCycleAdjustor.h"
#import "FTOWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "FTOWorkout.h"

@implementation FTOCycleAdjustorTests

-(void) testDetectsCycleNeedingToAdjust {
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *ftoWorkout) {
        ftoWorkout.done = YES;
    }];
    STAssertTrue([[FTOCycleAdjustor new] cycleNeedsToIncrement], @"");
}

-(void) testDetectsCycleNotNeedingToAdjust {
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *ftoWorkout) {
        ftoWorkout.done = YES;
    }];
    [[[FTOWorkoutStore instance] first] setDone: NO];
    STAssertFalse([[FTOCycleAdjustor new] cycleNeedsToIncrement], @"");
}

@end