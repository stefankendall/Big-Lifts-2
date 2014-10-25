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
#import "JFTOCustomAssistanceLiftStore.h"
#import "JFTOCustomAssistanceLift.h"
#import "JSetStore.h"
#import "JSet.h"
#import "JWorkout.h"

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

- (void)testDoesNotRemoveFtoLiftSetsWhenCustomLiftsAreRemoved {
    JFTOCustomAssistanceLift *customLift = [[JFTOCustomAssistanceLiftStore instance] create];
    customLift.name = @"Custom Lift";

    JFTOFullCustomAssistanceWorkout *customWorkout = [[JFTOFullCustomAssistanceWorkoutStore instance] first];

    JSet *set1 = [[JSetStore instance] create];
    set1.lift = customLift;

    JSet *set2 = [[JSetStore instance] create];
    set2.lift = [[JFTOLiftStore instance] first];

    JSet *set3 = [[JSetStore instance] create];
    set3.lift = customLift;

    JSet *set4 = [[JSetStore instance] create];
    set4.lift = [[JFTOLiftStore instance] last];


    [customWorkout.workout addSet:set1];
    [customWorkout.workout addSet:set2];
    [customWorkout.workout addSet:set3];
    [customWorkout.workout addSet:set4];

    [[JFTOCustomAssistanceLiftStore instance] removeAtIndex:0];

    STAssertEquals((int) [[customWorkout.workout sets] count], 2, @"");
}

@end