#import "Workout.h"
#import "FTOBoringButBigViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOBoringButBigViewController.h"
#import "FTOAssistanceStore.h"
#import "FTOAssistance.h"
#import "FTOWorkout.h"
#import "FTOWorkoutStore.h"
#import "SetData.h"
#import "FTOCycleAdjustor.h"

@implementation FTOBoringButBigViewControllerTests

- (void)testChangingPercentageUpdatesBbbLifts {
    [[FTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    FTOBoringButBigViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoBoring"];
    UITextField *field = [UITextField new];
    field.text = @"60";
    [controller percentageChanged:field];

    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEquals([ftoWorkout.workout.orderedSets count], 11U, @"");
    STAssertEqualObjects([[ftoWorkout.workout.orderedSets lastObject] percentage], N(60), @"");
}

- (void)testThreeMonthChallengeUntoggled {
    [[FTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    [[FTOCycleAdjustor new] nextCycle];

    FTOWorkout *ftoWorkout = [[[FTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    STAssertEqualObjects([ftoWorkout.workout.orderedSets.lastObject percentage], N(50), @"");
}

- (void)testThreeMonthChallengeToggled {
    [[FTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    FTOBoringButBigViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoBoring"];
    UISwitch *toggle = [UISwitch new];
    [toggle setOn:YES];
    [controller toggleThreeMonthChallenge:toggle];
    [[FTOCycleAdjustor new] nextCycle];

    FTOWorkout *ftoWorkout = [[[FTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    STAssertEqualObjects([ftoWorkout.workout.orderedSets.lastObject percentage], N(60), @"");
}

@end