#import "JFTOFullCustomWeekStoreTests.h"
#import "JFTOFullCustomWeekStore.h"
#import "JFTOFullCustomWeek.h"
#import "JFTOFullCustomWorkoutStore.h"

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

@end