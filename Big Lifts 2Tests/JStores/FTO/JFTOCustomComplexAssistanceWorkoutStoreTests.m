#import "JFTOCustomComplexAssistanceWorkoutStoreTests.h"
#import "JFTOCustomComplexAssistanceWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "JFTOCustomComplexAssistanceWorkout.h"
#import "JLift.h"
#import "JFTOLift.h"
#import "JFTOLiftStore.h"
#import "JFTOWorkoutStore.h"
#import "JFTOSettingsStore.h"
#import "JFTOSettings.h"

@implementation JFTOCustomComplexAssistanceWorkoutStoreTests

- (void)testAddsMissingLifts {
    NSArray *assistance = [[JFTOCustomComplexAssistanceWorkoutStore instance] findAll];
    STAssertEquals((int) [assistance count], 16, @"");

    NSArray *bench = [assistance select:^BOOL(JFTOCustomComplexAssistanceWorkout *workout) {
        return [workout.mainLift.name isEqualToString:@"Bench"];
    }];
    STAssertEquals((int) [bench count], 4, @"");
}

- (void)testRemovesMissingLifts {
    [[JFTOLiftStore instance] removeAtIndex:0];
    STAssertEquals([[JFTOCustomComplexAssistanceWorkoutStore instance] count], 12, @"");
}

- (void)testAddsRemovesWeeksForSixWeek {
    [[[JFTOSettingsStore instance] first] setSixWeekEnabled:YES];
    [[JFTOWorkoutStore instance] switchTemplate];

    STAssertEquals((int) [[[JFTOCustomComplexAssistanceWorkoutStore instance] findAll] count], 28, @"");

    [[[JFTOSettingsStore instance] first] setSixWeekEnabled:NO];
    [[JFTOWorkoutStore instance] switchTemplate];

    STAssertEquals((int) [[[JFTOCustomComplexAssistanceWorkoutStore instance] findAll] count], 16, @"");
}

@end