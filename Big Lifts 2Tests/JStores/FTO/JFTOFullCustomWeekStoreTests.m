#import "JFTOFullCustomWeekStoreTests.h"
#import "JFTOFullCustomWeekStore.h"
#import "JFTOFullCustomWeek.h"
#import "JFTOFullCustomWorkoutStore.h"
#import "JFTOWorkoutStore.h"
#import "JFTOVariantStore.h"
#import "JFTOVariant.h"
#import "JFTOWorkout.h"
#import "JWorkout.h"

@implementation JFTOFullCustomWeekStoreTests

- (void)testHasWeekNames {
    JFTOFullCustomWeek *customWeek = [[JFTOFullCustomWeekStore instance] find:@"week" value:@1];
    STAssertEqualObjects(customWeek.name, @"5/5/5", @"");
}

- (void)testSetsWeekIncrement {
    STAssertFalse([[[JFTOFullCustomWeekStore instance] find:@"week" value:@1] incrementAfterWeek], @"");
    STAssertFalse([[[JFTOFullCustomWeekStore instance] find:@"week" value:@2] incrementAfterWeek], @"");
    STAssertFalse([[[JFTOFullCustomWeekStore instance] find:@"week" value:@3] incrementAfterWeek], @"");
    STAssertTrue([[[JFTOFullCustomWeekStore instance] find:@"week" value:@4] incrementAfterWeek], @"");
}

- (void)testHasCustomWorkouts {
    JFTOFullCustomWeek *customWeek1 = [[JFTOFullCustomWeekStore instance] find:@"week" value:@1];
    JFTOFullCustomWeek *customWeek2 = [[JFTOFullCustomWeekStore instance] find:@"week" value:@2];
    STAssertEquals((int) [customWeek1.workouts count], 4, @"");
    STAssertEquals((int) [customWeek2.workouts count], 4, @"");
}

- (void)testDeletingWorkoutWeekRemovesCustomWorkouts {
    int count = [[JFTOFullCustomWorkoutStore instance] count];
    [[JFTOFullCustomWeekStore instance] removeAtIndex:0];
    STAssertEquals([[JFTOFullCustomWorkoutStore instance] count], count - 4, @"");
}

- (void)testSortsByWeek {
    JFTOFullCustomWeek *week1 = [[JFTOFullCustomWeekStore instance] atIndex:0];
    JFTOFullCustomWeek *week2 = [[JFTOFullCustomWeekStore instance] atIndex:1];

    week1.week = @2;
    week2.week = @1;

    STAssertEquals([[JFTOFullCustomWeekStore instance] findAll][0], week2, @"");
    STAssertEquals([[JFTOFullCustomWeekStore instance] findAll][1], week1, @"");
}

- (void)testDeleting531WeekDoesNotCreateEmptyDeloadWorkouts {
    [[JFTOFullCustomWeekStore instance] removeAtIndex:2];
    [[JFTOVariantStore instance] changeTo:FTO_VARIANT_FULL_CUSTOM];

    STAssertEquals([[JFTOWorkoutStore instance] count], 12, @"");

    NSArray *deloadWeek = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@3];
    STAssertEquals((int) [deloadWeek count], 4, @"");
    JFTOWorkout *firstWorkoutInDeload = [[JFTOWorkoutStore instance] first];
    STAssertEquals((int) firstWorkoutInDeload.workout.sets.count, 6, @"");
}

- (void)testRemovingAWeekRestitchesWeekValues {
    [[JFTOFullCustomWeekStore instance] removeAtIndex:2];
    STAssertNotNil([[JFTOFullCustomWeekStore instance] find:@"week" value:@3], @"");
}

@end