#import "JFTOFullCustomAssistanceWorkoutStoreTests.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "JFTOFullCustomAssistanceWorkout.h"
#import "JLift.h"
#import "JFTOLift.h"
#import "JFTOLiftStore.h"
#import "JFTOWorkoutStore.h"
#import "JFTOSettingsStore.h"
#import "JFTOSettings.h"

@implementation JFTOFullCustomAssistanceWorkoutStoreTests

- (void)testAddsMissingLifts {
    NSArray *assistance = [[JFTOFullCustomAssistanceWorkoutStore instance] findAll];
    STAssertEquals((int) [assistance count], 16, @"");

    NSArray *bench = [assistance select:^BOOL(JFTOFullCustomAssistanceWorkout *workout) {
        return [workout.mainLift.name isEqualToString:@"Bench"];
    }];
    STAssertEquals((int) [bench count], 4, @"");
}

- (void)testRemovesMissingLifts {
    [[JFTOLiftStore instance] removeAtIndex:0];
    STAssertEquals([[JFTOFullCustomAssistanceWorkoutStore instance] count], 12, @"");
}

- (void)testAddsRemovesWeeksForSixWeek {
    [[[JFTOSettingsStore instance] first] setSixWeekEnabled:YES];
    [[JFTOWorkoutStore instance] switchTemplate];

    STAssertEquals((int) [[[JFTOFullCustomAssistanceWorkoutStore instance] findAll] count], 28, @"");

    [[[JFTOSettingsStore instance] first] setSixWeekEnabled:NO];
    [[JFTOWorkoutStore instance] switchTemplate];

    STAssertEquals((int) [[[JFTOFullCustomAssistanceWorkoutStore instance] findAll] count], 16, @"");
}

@end